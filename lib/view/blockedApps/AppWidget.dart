import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weparent/model/app.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:http/http.dart' as http;
import '/utils/constants.dart' as constants;

class AppWidget extends StatefulWidget {
  final App app;

  AppWidget(this.app);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  bool _status = false;

  @override
  void initState() {
    _status = widget.app.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 337,
      height: 80,
      margin: EdgeInsets.only(left: 25, top: 20, right: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Image.asset(widget.app.image, width: 40, height: 40),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.app.name,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  height: 1.2,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 3),
              Text(
                _status ? 'unrestricted' : 'restricted',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  height: 1.2,
                  color: Color(0xFF00349A),
                ),
              ),
            ],
          ),
          Spacer(),
          SizedBox(
            width: 5,
            height: 10,
          ),
          Container(
            child: LiteRollingSwitch(
              value: _status,
              textOn: 'Available',
              textOff: 'Blocked',
              colorOn: Colors.green,
              colorOff: Colors.red,
              iconOn: Icons.done,
              iconOff: Icons.remove_circle_outline,
              textSize: 10.0,
              onChanged: (value) async {
                final response = await http.post(
                    Uri.parse('${constants.SERVER_URL}/application/block'),
                    body: {
                      'id': widget.app.id,
                      'blocked': value.toString(),
                    });
                if (response.statusCode == 200) {
                  setState(() {
                    _status = value;
                    widget.app.status = value;
                  });
                } else {
                  // handle error
                }
              },
              // handle switch change
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
            ),
          )
        ],
      ),
    );
  }
}
