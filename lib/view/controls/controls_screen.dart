import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '/utils/constants.dart' as constants;
import 'package:weparent/view/login/login_screen.dart';

class ControlsScreen extends StatefulWidget {

  const ControlsScreen({super.key});
  @override
  _ControlsScreenState createState() => _ControlsScreenState();
}

class _ControlsScreenState extends State<ControlsScreen> {

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
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            Card(
            elevation: 1.0,
            margin: new EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
              child: new InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    Center(
                        child: Icon(
                          Icons.screenshot_monitor,
                          size: 50.0,
                          color: Colors.black,
                        )),
                    SizedBox(height: 20.0),
                    new Center(
                      child: new Text("Screenshots",
                          style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                    )
                  ],
                ),
              ),
            )),
        Card(
            elevation: 1.0,
            margin: new EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
              child:  InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    const Center(
                        child: Icon(
                          Icons.lock,
                          size: 50.0,
                          color: Colors.black,
                        )),
                    SizedBox(height: 20.0),
                     Center(
                      child:  Text("Lock Screen",
                          style:
                           TextStyle(fontSize: 18.0, color: Colors.black)),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      )

    );
  }



}
