import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../model/receivedlocation.dart';
import '/utils/constants.dart' as constants;

import 'package:maps_toolkit/maps_toolkit.dart' as toolkit;

class map extends StatefulWidget {
  const map({Key? key}) : super(key: key);

  @override
  State<map> createState() => mapsState();
}

class mapsState extends State<map> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _mapController;
  late IO.Socket socket;
  List<LatLng> polylineCoordinates = [];

  double? _Latitude;
  double? _Longitude;
  LatLng? _point1;
  LatLng? _point2;
  LatLng? _point3;
  LatLng? _point4;
  bool _canSetSafeZone = false;
  Set<Polygon> _polygon = HashSet<Polygon>();
  Set<Polyline> _safeZonePolyline = HashSet<Polyline>();
  int count = 0;

  Set<Polyline> _polylines = {};
  // tjibhom mel back tzid f child entity LocationPoint1 , 2 ,3 , 4
  List<LatLng> points = [];
  List<LatLng> serverPoints = [];

  //updateLocation taaytelha init state
  void UpdateLocation() async {
    String? buildId = await getBuildId();

    socket = io(
        constants.SERVER_URL,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() //
            .setQuery({"buildId": buildId})
            .build());
    socket.connect();
    socket.emit("connection");
    socket.on("location", (data) async {
      final regex = RegExp(r'([-\d.]+)');
      final matches = regex.allMatches(data);

      final parsedlatitude = double.parse(matches.elementAt(0).group(0)!);
      final parsedlongitude = double.parse(matches.elementAt(1).group(0)!);

      final loc = receivedlocation(
          parsedlatitude.toString(), parsedlongitude.toString());

      final locat = LatLng(parsedlatitude, parsedlongitude);
      print(locat);
      final res = isLatLngWithinSquare(locat,_point1!,_point2!,_point3!,_point4!);

      if (res == false) {
      if(ScaffoldMessenger.of(context).mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds:700),
            backgroundColor: Colors.redAccent,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "CHILD OUTSIDE OF SAFE ZONE",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.location_off_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      }


        print('The point is outside the square zone.');
      }
      else {

      }

      if (mounted) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('LASTLATITUDE', loc.latitude.toString());
        prefs.setString('LASTLONGITUDE', loc.longitude.toString());

        setState(() {
          _Latitude = double.parse(loc.latitude!);
          _Longitude = double.parse(loc.longitude!);
        });
      }
    });
  }

  Future<String?> getBuildId() async {
    String? result = await PlatformDeviceId.getDeviceId;
    return result;
  }

  Future<void> GetLastLocation() async {
    final prefs = await SharedPreferences.getInstance();
    String? lat = await prefs.getString('LASTLATITUDE');
    String? long = await prefs.getString('LASTLONGITUDE');

    if (lat != null && long != null) {
      setState(() {
        _Latitude = double.parse(lat!);
        _Longitude = double.parse(long!);
      });
    }
  }

  void getSafeZone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tok = prefs.getString("Token");

    final url = Uri.parse('${constants.SERVER_URL}/parent/SetSafeZone');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': '$tok'},
    );

    if (response.statusCode == 200) {
      print("get safezone works");
      final data = await jsonDecode(response.body);
      final pt1 = data['SafeZonePoint1'];
      final pt2 = data['SafeZonePoint2'];
      final pt3 = data['SafeZonePoint3'];
      final pt4 = data['SafeZonePoint4'];






        setState(() {
          _point1 = LatLng(
              double.parse(pt1.split('+')[0]), double.parse(pt1.split('+')[1]));
          _point2 = LatLng(
              double.parse(pt2.split('+')[0]), double.parse(pt2.split('+')[1]));
          _point3 = LatLng(
              double.parse(pt3.split('+')[0]), double.parse(pt3.split('+')[1]));
          _point4 = LatLng(
              double.parse(pt4.split('+')[0]), double.parse(pt4.split('+')[1]));

          serverPoints.add(_point1!);
          serverPoints.add(_point2!);
          serverPoints.add(_point3!);
          serverPoints.add(_point4!);
          print(serverPoints);

          _polygon = HashSet<Polygon>.of([
            Polygon(
              polygonId: PolygonId('1'),
              points: [LatLng(10.218079090118408, 36.73352914145773), LatLng(10.32963015139103, 36.810518412777746), LatLng(10.366560481488705, 36.73467325298344), LatLng(10.29668491333723, 36.672827844810094)],      fillColor: Colors.green.withOpacity(0.3),
              strokeColor: Colors.green,
              geodesic: true,
              strokeWidth: 4,
            ),
          ]);
        });


    } else {

    }
  }

  Future<void> setSafeZone(receivedlocation pt1, receivedlocation pt2,
      receivedlocation pt3, receivedlocation pt4) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tok = prefs.getString("Token");
    prefs.setString('SafeZonePoint1', pt1.toString());
    prefs.setString('SafeZonePoint2', pt2.toString());
    prefs.setString('SafeZonePoint3', pt3.toString());
    prefs.setString('SafeZonePoint4', pt4.toString());
    prefs.reload();

    final url = Uri.parse('${constants.SERVER_URL}/parent/SetSafeZone');

    final response = await http.put(
      url,
      body: json.encode(
        {
          'SafeZonePoint1':
              "${pt1.latitude.toString()}+${pt1.longitude.toString()}",
          'SafeZonePoint2':
              "${pt2.latitude.toString()}+${pt2.longitude.toString()}",
          'SafeZonePoint3':
              "${pt3.latitude.toString()}+${pt3.longitude.toString()}",
          'SafeZonePoint4':
              "${pt4.latitude.toString()}+${pt4.longitude.toString()}",
        },
      ),
      headers: {'Content-Type': 'application/json', 'Authorization': '$tok'},
    );
    if (response.statusCode == 200) {






      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 900),
          backgroundColor: Colors.lightGreen,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Safe zone set successfully",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.check_circle_outline,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
      print('Points added to MongoDB');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 900),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "You have no linked children",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }
  }



  @override
  void initState() {
    super.initState();
    _Latitude = 36.8439235819203;
    _Longitude = 10.150833763182163;


    getSafeZone();
    GetLastLocation();
    UpdateLocation();

  }

  @override
  void _onMapCreated(GoogleMapController controller) {
    // List<LatLng> newList = await getSafeZone();

    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tzid icon lfouk alisr wala boutton "Set safe zone"
    // Click on 4 different point that you wish to be the safe zone
    // when confirmed, save to parent's child. send request "SetChildSafeZone"
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              if (!_canSetSafeZone) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actions: [

                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                dialogStartButton();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Color(0xFFBC539F)),
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "SET A SAFEZONE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    ),
                              ),
                            ),
                          ),

                      ],
                      title: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Set a safe zone",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFBC539F))),
                      ),
                      titleTextStyle: TextStyle(),
                      content: const Text(
                        "You can set a safe zone for your child and get notified if he crosses it. Click start and place 4 points on the map and then click on the map for a fifth time.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )
        ],
        iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
        title: const Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.map),
                ),
              ),
              TextSpan(text: 'Location'),
            ],
          ),
        ),
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),
      body: _Latitude == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_Latitude!, _Longitude!),
                zoom: 10.5,
              ),
              trafficEnabled: true,
              polygons: _polygon,
              polylines: _polylines,
              onCameraMove: _onCameraMove,
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(
                      //_latitude
                      _Latitude!,
                      _Longitude!),
                  draggable: false,
                ),
              },
              onMapCreated: (mapController) {
                _onMapCreated(mapController);
                _controller.complete(mapController);
              },
              onTap: (LatLng tappedLocation) {
                if (!_canSetSafeZone) {
                } else {
                  if (points.length == 4) {
                    var pt1 = receivedlocation(points[0].latitude.toString(),
                        points[0].longitude.toString());
                    var pt2 = receivedlocation(points[1].latitude.toString(),
                        points[1].longitude.toString());
                    var pt3 = receivedlocation(points[2].latitude.toString(),
                        points[2].longitude.toString());
                    var pt4 = receivedlocation(points[3].latitude.toString(),
                        points[3].longitude.toString());
                    setSafeZone(pt1, pt2, pt3, pt4);

                    setState(() {
                      _point1 =points[0];
                          _point2 =points[1];
                          _point3 =points[2];
                          _point4 =points[3];
                    });

                    SnackBar(
                      content: Text('You have inserted 4 points'),
                      duration: const Duration(seconds: 2),
                    );

                    points.clear();
                    _canSetSafeZone = false;
                  } else {
                    points.add(tappedLocation);
                  }
                  setState(() {
                    _polygon = HashSet<Polygon>.of([
                      Polygon(
                        polygonId: PolygonId('1'),
                        points: points,
                        fillColor: Colors.green.withOpacity(0.3),
                        strokeColor: Colors.green,
                        geodesic: true,
                        strokeWidth: 4,
                      ),
                    ]);
                  });
                }
              },
            ),
    );
  }

  bool isLatLngWithinSquare(LatLng locat, LatLng point1, LatLng point2, LatLng point3, LatLng point4) {
    final maxLat = math.max(point1.latitude, math.max(point2.latitude, math.max(point3.latitude, point4.latitude)));
    final minLat = math.min(point1.latitude, math.min(point2.latitude, math.min(point3.latitude, point4.latitude)));
    final maxLng = math.max(point1.longitude, math.max(point2.longitude, math.max(point3.longitude, point4.longitude)));
    final minLng = math.min(point1.longitude, math.min(point2.longitude, math.min(point3.longitude, point4.longitude)));

    return locat.latitude >= minLat && locat.latitude <= maxLat && locat.longitude >= minLng && locat.longitude <= maxLng;
  }

  void dialogStartButton() {
    if (!_canSetSafeZone) {
      setState(() {
        _canSetSafeZone = true;
      });

      Navigator.pop(context);
    }
  }
}
