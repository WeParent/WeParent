import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import '/utils/constants.dart' as constants;
import 'package:weparent/view/login/login_screen.dart';

class ControlsScreen extends StatefulWidget {

  const ControlsScreen({super.key});
  @override
  _ControlsScreenState createState() => _ControlsScreenState();
}

class _ControlsScreenState extends State<ControlsScreen> {
   String? _connectivity;
  late IO.Socket socket;


  void listenForSocket() async {
    String? buildId = await getBuildId();

    socket = io(
        constants.SERVER_URL,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() //
            .setQuery({"buildId": buildId.toString()})
            .build());
    socket.connect();
    socket.emit("connection");


    socket.on("panicalert",(data) {
      print("PANIC ALLLERRRTTTT");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 60),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Child is sending a panic alert !",
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


    });

    socket.on("batterylevel", (data) async {
      print("BATTERYLEVEL IS $data");

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('CHILDBATTERY',data);

      if (double.parse(data) < 20)  {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 900),
            backgroundColor: Colors.redAccent,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Child battery is lower than 20%",
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


    });

    socket.on("screentime", (data)  {
   //   print("SCREENTIME IS $data");
    });


    socket.on("connectivity", (data)  async {
      final prefs = await SharedPreferences.getInstance();
      print("CONNECTIVITY IS $data");
      if (data =="WIFI") {

        prefs.setString('CHILDCONNECTIVITY',"WIFI");
      }
      if(data == "4G") {

        prefs.setString('CHILDCONNECTIVITY',"4G");
      }

    });
  }

  Future<String?> getBuildId() async {
    String? result = await PlatformDeviceId.getDeviceId;
    return result;
  }

  @override
  void initState() {
    super.initState();
    listenForSocket();
  }
 @override
  void dispose() {
    // TODO: implement dispose
   socket.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
          automaticallyImplyLeading: false,
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
        // Handle back button press
        Navigator.pop(context);
        },
        ),
          iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
          title: const Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.phonelink_setup),
                  ),
                ),
                TextSpan(text: 'Controls'),
              ],
            ),
          ),
          foregroundColor: const Color(0xFFBC539F),
          centerTitle: true),

      body: Container(

        padding: EdgeInsets.symmetric( horizontal: 0.0,vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisCount: 2,
                padding: EdgeInsets.all(5.0),
                children: <Widget>[
                  Card(
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 2,
                  margin: new EdgeInsets.all(8.0),
                  child: Container(
                    child: InkWell(

                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        verticalDirection: VerticalDirection.down,
                        children: const <Widget>[
                          SizedBox(height: 20.0),
                          Center(
                              child:  Image(
                                image: AssetImage('Assets/screenshot.png'),
                                height: 90,
                                width:90,
                              )),
                          SizedBox(height: 15.0),
                           Center(
                            child:  Text("Screenshots",
                                style:
                                TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0, color: Color(0xFFBC539F))),
                          )
                        ],
                      ),
                    ),
                  )),
              Card(
                  shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 2,
                  margin: new EdgeInsets.all(8.0),
                  child: Container(
                    child:  InkWell(
                      onTap: () async {



                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        verticalDirection: VerticalDirection.down,
                        children: const <Widget>[
                          SizedBox(height: 20.0),
                          Center(
                              child: Image(
                                image: AssetImage('Assets/emailReset.png'),
                                height: 90,
                                width:90,
                              )),
                          SizedBox(height: 15.0),
                           Center(
                            child:  Text("Lock screen",
                                style:
                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0, color: Color(0xFFBC539F))),
                          )
                        ],
                      ),
                    ),
                  )),
                  Card(
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 2,
                      margin: new EdgeInsets.all(8.0),
                      child: Container(
                        child:  InkWell(
                          onTap: () async {

                            final prefs = await SharedPreferences.getInstance();
                            final res = prefs.getString("CHILDBATTERY");
                            print(res);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 3),
                                backgroundColor: Colors.greenAccent,
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Text(
                                      "Child battery level is $res",
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


                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: const <Widget>[
                              SizedBox(height: 20.0),
                              Center(
                                  child: Image(
                                    image: AssetImage('Assets/battery.png'),
                                    height: 90,
                                    width:90,
                                  )),
                              SizedBox(height: 15.0),
                              Center(
                                child:  Text("Battery",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0, color: Color(0xFFBC539F))),
                              )
                            ],
                          ),
                        ),
                      )),
                  Card(
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 2,
                      margin: new EdgeInsets.all(8.0),
                      child: Container(
                        child:  InkWell(
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            final res = prefs.getString("CHILDCONNECTIVITY");
                            print(res);

                            if(res == "WIFI") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.greenAccent,
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Child is connected via WIFI",
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
                            }
                            if(res == "4G") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.greenAccent,
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Child is connected via 4G",
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
                            }
                            if(res == "OFFLINE") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.redAccent,
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Child is offline",
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
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: const <Widget>[
                              SizedBox(height: 20.0),
                              Center(
                                  child: Image(
                                    image: AssetImage('Assets/connectivity.png'),
                                    height: 90,
                                    width:90,
                                  )),
                              SizedBox(height: 15.0),
                              Center(
                                child:  Text("Connectivity",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0, color: Color(0xFFBC539F))),
                              )
                            ],
                          ),
                        ),
                      ))

                ],
              ),
            ),
            Expanded(
              child: Card(
                  shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 2,
                  margin: new EdgeInsets.all(15.0),
                  child: Container(
                    child:  InkWell(
                      onTap: () {

                        Navigator.pushNamed(context, '/apps');

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        verticalDirection: VerticalDirection.down,
                        children: const <Widget>[
                          SizedBox(height: 10.0),
                          Center(
                              child: Image(
                                image: AssetImage('Assets/apps.png'),
                                height: 250,
                                width:300,
                                fit: BoxFit.contain,
                              )),
                          SizedBox(height: 30.0),
                          Center(
                            child:  Text("Applications",
                                style:
                                TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0, color: Color(0xFFBC539F))),
                          )
                        ],
                      ),
                    ),
                  )
              ),
            )
          ],
        ),
      )

    );
  }



}
