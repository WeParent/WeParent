import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_common/src/util/event_emitter.dart';
import 'package:weparent/model/app.dart';
import 'package:weparent/utils/receivedlocation.dart';
import 'package:weparent/view/map/constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class map extends StatefulWidget {
  const map({Key? key}) : super(key: key);

  @override
  State<map> createState() => mapsState();
}

class mapsState extends State<map> {
  final Completer<GoogleMapController> _controller = Completer();
  late IO.Socket socket;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
   double? _Latitude = 1.0000;
   double? _Longitude ;
  Set<Polygon> _polygon = HashSet<Polygon>();
  int count = 0;




  // tjibhom mel back tzid f child entity LocationPoint1 , 2 ,3 , 4
  List<LatLng> points= [];



  //updateLocation taaytelha init state
  void UpdateLocation() async {
    //lezemna nalkawoulha 7al
    String? result = await PlatformDeviceId.getDeviceId;
    print("buildId est $result");
     socket = io('http://172.16.1.96:9090',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // disable auto-connection²
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
      setState(() {
    _Latitude = double.parse(loc.latitude!);
    _Longitude = double.parse(loc.longitude!);


       });
    });
  }

  @override
   initState()  {
    _Longitude = 20.1550121;
    _Latitude = 30.8650623;

    super.initState();
    points.clear();
    UpdateLocation();
    // wait for the Future to complete before continuing


      // _polygon.add(
      //   Polygon(
      //     // given polygonId
      //     polygonId: PolygonId('1'),
      //     // initialize the list of points to display polygon
      //     points: points,
      //     // given color to polygon
      //     fillColor: Colors.purple.withOpacity(0.3),
      //     // given border color to polygon
      //     strokeColor: Colors.green,
      //     geodesic: true,
      //     // given width of border
      //     strokeWidth: 4,
      //   ),
      // );

  }

  void _saveSafeZonePoints() {
    if (points.length != 4) {
      return;
    }
    socket.emit('SetChildSafeZone', {'points': points});
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
                _saveSafeZonePoints();
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
        _Latitude! == null ? Center(child: CircularProgressIndicator()) :
      GoogleMap(
         initialCameraPosition: CameraPosition(
           target: LatLng(
               _Latitude!, _Longitude!)
           ,

                zoom: 18.5,
         ),
         polylines: {
           Polyline(
             polylineId: const PolylineId("route"),
             points: polylineCoordinates,
             color: const Color(0xFF7B61FF),
             width: 6,
           ),
         }, polygons: _polygon,
         markers: {
           Marker(
            markerId: const MarkerId("currentLocation"),
             position: LatLng(
               //_latitude
                 _Latitude!, _Longitude!),
           ),


         },
         onMapCreated: (mapController) {
           _controller.complete(mapController);
         },

     onTap: (LatLng tappedLocation) {

        // Add tapped location to safe zone points list
        points.add(tappedLocation);
        count = count++;

    // Update polygon with new safe zone points
    setState(() {
      _polygon = HashSet<Polygon>.of([
        Polygon(
          polygonId: PolygonId('1'),
          points: points,
          fillColor: Colors.purple.withOpacity(0.3),
          strokeColor: Colors.green,
          geodesic: true,
          strokeWidth: 4,
        ),
      ]);
    });
    if(count > 4){
      SnackBar(
        content: Text('You have inserted more than 4 points'),
        duration: const Duration(seconds: 2),
      );



    }
  },

       ),

    );
  }
}
