import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/utils/constants.dart' as constants;

class ScreenTimeLimitScreen extends StatefulWidget {
  @override
  _ScreenTimeLimitScreenState createState() => _ScreenTimeLimitScreenState();
}

class _ScreenTimeLimitScreenState extends State<ScreenTimeLimitScreen> {
  int _hours = 0;
  int _minutes = 0;
  int _remainingTime = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {});
    _timer.cancel();
  }

  void _setTimeLimit() async {
    final url = Uri.parse('${constants.SERVER_URL}/parent');
    setState(() {
      _remainingTime = _hours * 60 + _minutes;
    });
    _timer.cancel();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        _remainingTime--;
        if (_remainingTime == 0) {
          _timer.cancel();
          // display a message to the user
        }
      });
    });
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          "childId": "642370452dc3b0a0a24edeac",
          'timeLimit': _remainingTime
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        // Successfully set the time limit
        print('Time limit set successfully');
      } else {
        // Failed to set the time limit
        print('Failed to set the time limit');
      }
    } catch (e) {
      // An error occurred while trying to set the time limit
      print('An error occurred while trying to set the time limit');
    }
  }

  String _formatTime(int time) {
    String hours = (time ~/ 60).toString().padLeft(2, '0');
    String minutes = (time % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  double _getPercentRemaining() {
    int totalMinutes = (_hours * 60) + _minutes;
    double remainingMinutes = _remainingTime.clamp(0, totalMinutes).toDouble();
    return remainingMinutes / totalMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
        title: const Text("Screen Time Limit"),
        shadowColor: Colors.grey,
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30.0),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  color: Color(0xffDBD6FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(41),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16.0),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CircularPercentIndicator(
                            radius: 110.0,
                            lineWidth: 10.0,
                            percent: _getPercentRemaining(),
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Remaining',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                //SizedBox(height: 3.0),
                                Text(
                                  _formatTime(_remainingTime),
                                  style: TextStyle(
                                    fontSize: 45.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            progressColor: Color(0xff00349A),
                            backgroundColor: Colors.white,
                            animation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: NumberPicker(
                                    value: _hours,
                                    minValue: 0,
                                    maxValue: 23,
                                    onChanged: (value) {
                                      setState(() {
                                        _hours = value;
                                      });
                                    },
                                    selectedTextStyle: TextStyle(
                                      color: Color(0xff00349A),
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Hours',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 32.0),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: NumberPicker(
                                    value: _minutes,
                                    minValue: 0,
                                    maxValue: 59,
                                    onChanged: (value) {
                                      setState(() {
                                        _minutes = value;
                                      });
                                    },
                                    selectedTextStyle: TextStyle(
                                      color: Color(0xff00349A),
//fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Minutes',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        SizedBox(
                          height: 45,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: _setTimeLimit,
                            child: Text(
                              'Add time',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
//side: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
