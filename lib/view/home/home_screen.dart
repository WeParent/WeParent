import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weparent/model/child.dart';
import 'package:weparent/model/childcard.dart';
import 'package:weparent/view/blockedApps/BlockedApps.dart';
import 'package:weparent/view/home/stats_screen.dart';
import '/utils/constants.dart' as constants;

import 'package:platform_device_id/platform_device_id.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fluttertoast/fluttertoast.dart';


class home_screen extends StatefulWidget {

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  late IO.Socket socket;

  void listenForSocket() async {
    String? buildId = await getBuildId();

    socket = io(
        constants.SERVER_URL,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() //
            .setQuery({"buildId": "ba6261425ae531ea"})
            .build());
    socket.connect();
    socket.emit("connection");
    socket.on("batterylevel", (data) async {
      print("BATTERYLEVEL IS $data");
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
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
        title: const Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.home_filled),
                ),
              ),
              TextSpan(text: 'Home'),
            ],
          ),
        ),

          automaticallyImplyLeading: false,
        foregroundColor: const Color(0xFFBC539F),
        centerTitle: true,
      ),
      body: StatsScreen()
    );
  }
}
