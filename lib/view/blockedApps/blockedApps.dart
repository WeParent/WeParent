import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:weparent/model/app.dart';
import 'package:weparent/view/blockedApps/AppWidget.dart';
import '/utils/constants.dart' as constants;

class BlockedApps extends StatefulWidget {
  @override
  _BlockedAppsState createState() => _BlockedAppsState();
}

class _BlockedAppsState extends State<BlockedApps> {
  List<App> apps = [];

  @override
  void initState() {
    super.initState();
    fetchApps();
  }

  Future<void> fetchApps() async {
    final response = await http.post(
      Uri.parse('${constants.SERVER_URL}/application/get'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': "6400eb96a231e0530f0614fe"}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final List<App> fetchedApps = data
          .map((dynamic appData) => App(
                id: appData['_id'],
                image: 'Assets/${appData['Name']}.png',
                name: appData['Name'],
                status: appData['blocked'],
              ))
          .toList();

      setState(() {
        apps = fetchedApps;
      });
    } else {
      throw Exception('Failed to fetch apps');
    }
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
                  child: Icon(Icons.app_blocking),
                ),
              ),
              TextSpan(text: 'Blocked Apps'),
            ],
          ),
        ),
       
        foregroundColor: const Color(0xFFBC539F),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            height: 672,
            right: 0,
            left: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      left: 30,
                      right: 30,
                      bottom: 15,
                    ),
                    child: Text(
                      'App Restriction & Usage',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        height: 1.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: apps.map((app) => AppWidget(app)).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
