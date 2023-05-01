import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_common/src/util/event_emitter.dart';
import 'package:weparent/model/app.dart';
import 'package:weparent/utils/receivedlocation.dart';
import 'package:weparent/view/map/constant.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '/utils/constants.dart' as constants;
import 'package:maps_toolkit/maps_toolkit.dart'  as toolkit;


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
  List<LatLng>? _list = [];

   double? _Latitude;
   double? _Longitude ;

  Set<Polygon> _polygon = HashSet<Polygon>();
  Set<Polyline> _safeZonePolyline = HashSet<Polyline>() ;
  int count = 0;




  // tjibhom mel back tzid f child entity LocationPoint1 , 2 ,3 , 4
  List<LatLng> points= [];



  //updateLocation taaytelha init state
  void UpdateLocation() async {
    //lezemna nalkawoulha 7al
    String? result = await PlatformDeviceId.getDeviceId;
    print(result);
    print("buildId est $result");
     socket = io('http://172.16.4.240:9090',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() //

           .setQuery({"buildId": result})
            .build()

    );
    socket.connect();
    socket.emit("connection");
    socket.on("location", (data) {


      final regex = RegExp(r'([-\d.]+)');
      final matches = regex.allMatches(data);

      final parsedlatitude = double.parse(matches.elementAt(0).group(0)!);
      final parsedlongitude = double.parse(matches.elementAt(1).group(0)!);

      final loc = receivedlocation(parsedlatitude.toString(), parsedlongitude.toString());
     if (mounted) {
       setState(() {
         _Latitude = double.parse(loc.latitude!);
         _Longitude = double.parse(loc.longitude!);


       });
     }

    });
  }

  Future<List<LatLng>> getSafeZone  ()  async {
    final prefs = await SharedPreferences.getInstance();
    String? pt1 = await prefs.getString('SafeZonePoint1');
    String? pt2 = await prefs.getString('SafeZonePoint2');
    String? pt3 = await prefs.getString('SafeZonePoint3');
    String? pt4 = await prefs.getString('SafeZonePoint4');
    RegExp regex = RegExp(r"[-]?[\d]*[.]?[\d]+");
    List<double> point1 = regex.allMatches(pt1!).map((match) =>
        double.parse(match.group(0)!)).toList();
    List<double> point2 = regex.allMatches(pt2!).map((match) =>
        double.parse(match.group(0)!)).toList();
    List<double> point3 = regex.allMatches(pt3!).map((match) =>
        double.parse(match.group(0)!)).toList();
    List<double> point4 = regex.allMatches(pt4!).map((match) =>
        double.parse(match.group(0)!)).toList();

    print(point1);
    // Create a LatLng object with the latitude and longitude values
    final list = [LatLng(point1[0], point1[1]),LatLng(point2[0], point2[1]),LatLng(point3[0], point3[1]),LatLng(point4[0], point4[1])];
    return list;













  }







  // DISABLE ON TAP
  Future<void> setSafeZone(receivedlocation pt1,receivedlocation pt2, receivedlocation pt3,receivedlocation pt4) async {
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
            'SafeZonePoint1':{
              "latitude":pt1.latitude,
              "longitude":pt1.longitude
            },
            'SafeZonePoint2':{
          "latitude":pt2.latitude,
          "longitude":pt2.longitude
          },
            'SafeZonePoint3':{
          "latitude":pt3.latitude,
          "longitude":pt3.longitude
          },
            'SafeZonePoint4':{
              "latitude":pt4.latitude,
              "longitude":pt4.longitude
            },

          },
        ),
        headers: {'Content-Type': 'application/json',
          'Authorization': '$tok'},
      );

    if(response.statusCode == 200) {
      print('Points added to MongoDB');
    } else {
      print('Failed to add points to MongoDB: ${response.statusCode}');
    }
  }
    /*
  bool _onCameraMove(CameraPosition position) {
     List<LatLng> polygonVertices = [LatLng(36.8439235819203, 10.150833763182163),
       LatLng(36.87658869351879, 10.186354592442513),
       LatLng(36.90326860074443, 10.152832344174385),
       LatLng(36.871530591136946, 10.120636448264122)] ;

       LatLng point = LatLng(_Latitude!,_Longitude!);
                  bool isPointInside = toolkit.PolygonUtil.containsLocation(
                          point as toolkit.LatLng, polygonVertices.cast<toolkit.LatLng>(), true);


                               return true;
  }
  */

  @override
   initState()  {


    super.initState();
    //getSafeZone();
    setState(() {
      _polygon = HashSet<Polygon>.of([
        Polygon(
          polygonId: PolygonId('1'),
          points: const [LatLng(36.8439235819203, 10.150833763182163), LatLng(36.87658869351879, 10.186354592442513), LatLng(36.90326860074443, 10.152832344174385), LatLng(36.871530591136946, 10.120636448264122)]
          ,
          fillColor: Colors.green.withOpacity(0.3),
          strokeColor: Colors.green,
          geodesic: true,
          strokeWidth: 4,
        ),
      ]);
    });
    UpdateLocation();
    // wait for the Future to complete before continuing


  }


  @override
  void _onMapCreated(GoogleMapController controller) async {

    List<LatLng> newList = await getSafeZone();
    setState(() {
      _polygon = HashSet<Polygon>.of([
        Polygon(
          polygonId: PolygonId('1'),
          points: const [LatLng(36.8439235819203, 10.150833763182163), LatLng(36.87658869351879, 10.186354592442513), LatLng(36.90326860074443, 10.152832344174385), LatLng(36.871530591136946, 10.120636448264122)]
        ,
          fillColor: Colors.green.withOpacity(0.3),
          strokeColor: Colors.green,
          geodesic: true,
          strokeWidth: 4,
        ),
      ]);
    });
    print("MAP CREATED");
    _mapController = controller;

  }
  bool isLatLngWithinSquare(LatLng point, LatLng corner1, LatLng corner2, LatLng corner3, LatLng corner4) {
    double minLat = _minOfFour(corner1.latitude, corner2.latitude, corner3.latitude, corner4.latitude);
    double maxLat = _maxOfFour(corner1.latitude, corner2.latitude, corner3.latitude, corner4.latitude);
    double minLng = _minOfFour(corner1.longitude, corner2.longitude, corner3.longitude, corner4.longitude);
    double maxLng = _maxOfFour(corner1.longitude, corner2.longitude, corner3.longitude, corner4.longitude);

    if (point.latitude >= minLat && point.latitude <= maxLat && point.longitude >= minLng && point.longitude <= maxLng) {
      // Check if the point is within the bounds of the square by using the cross product method
      bool isInside = false;
      for (int i = 0, j = 3; i < 4; j = i++) {
        if (((corner4.latitude > point.latitude) != (corner1.latitude > point.latitude)) &&
            (point.longitude < (corner3.longitude - corner4.longitude) * (point.latitude - corner4.latitude) / (corner3.latitude - corner4.latitude) + corner4.longitude)) {
          isInside = !isInside;
        }
      }
      return isInside;
    } else {
      return false;
    }
  }

  double _minOfFour(double a, double b, double c, double d) {
    return [a, b, c, d].reduce((value, element) => value < element ? value : element);
  }

  double _maxOfFour(double a, double b, double c, double d) {
    return [a, b, c, d].reduce((value, element) => value > element ? value : element);
  }
  void _onCameraMove(CameraPosition position) {
    LatLng point = LatLng(_Latitude!, _Longitude!); // San Francisco
    LatLng corner1 = LatLng(36.8439235819203, 10.150833763182163);
    LatLng corner2 = LatLng(36.87658869351879, 10.186354592442513);
    LatLng corner3 = LatLng(36.90326860074443, 10.152832344174385);
    LatLng corner4 = LatLng(36.871530591136946, 10.120636448264122);

    if (isLatLngWithinSquare(point, corner1, corner2, corner3, corner4)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('CHILD IS IN THE SAFEZONE'),
            duration: Duration(seconds: 2),
          ));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ALERT! CHILD IS OUTSIDE OF THE SAFEZONE'),
            duration: Duration(seconds: 2),
          )
      );


      print('The point is outside the square zone.');
    }
  }


  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tzid icon lfouk alisr wala boutton "Set safe zone"
    // Click on 4 different point that you wish to be the safe zone
    // when confirmed, save to parent's child. send request "SetChildSafeZone"
    return Scaffold(
      appBar: AppBar(
        title: Text('Text'),
        actions: [
          IconButton(
            icon: Icon(Icons.dangerous_rounded),
            color: Colors.purpleAccent,
            onPressed: () {
              if (points.length == 4) {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Safe zone points saved successfully.'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please select 4 points for the safe zone.'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },

            tooltip: 'Add Safe zone',
          ),
        ],
      ),body:
        _Latitude == null ? Center(child: CircularProgressIndicator()) :
      GoogleMap(
         initialCameraPosition: CameraPosition(
           target: LatLng(
               _Latitude!, _Longitude!) ,
                zoom: 18.5,
         ),
          polygons: _polygon,
         onCameraMove: _onCameraMove,
         markers: {
           Marker(
            markerId: const MarkerId("currentLocation"),
             position: LatLng(
               //_latitude
                 _Latitude!, _Longitude!),
           draggable: true,
           ),
         },
          onMapCreated: (mapController) {
          _onMapCreated(mapController);
           _controller.complete(mapController);
         },
     onTap: (LatLng tappedLocation) {
        // Add tapped location to safe zone points list
       //alkalha 7al bech twali tet3awed
       if(points.length == 4){
         var pt1 = receivedlocation(points[0].longitude.toString() ,points[0].latitude.toString());
         var pt2 = receivedlocation(points[1].longitude.toString(),points[1].latitude.toString());
         var pt3 = receivedlocation(points[2].longitude.toString(),points[2].latitude.toString());
         var pt4 = receivedlocation(points[3].longitude.toString(),points[3].latitude.toString());
         setSafeZone(pt1,pt2,pt3,pt4);
         SnackBar(
           content: Text('You have inserted 4 points'),
           duration: const Duration(seconds: 2),
         );
       } else {
         points.add(tappedLocation);
       }
    // kbal ma nhoto el points mel shared preferences fel plygon nbadlohom men JSON = List(LatLng)
    // Update polygon with new safe zone points
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
    print(points);
  },

       ),

    );
  }
}
