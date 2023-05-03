import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  SessionCheck() async {
    bool? loggedin = false;

    SharedPreferences prefs =  await SharedPreferences.getInstance();

    loggedin = prefs.getBool("isLoggedIn");
    final bool? verified = prefs.getBool("Verified");
    print(loggedin);
    if(loggedin != false && loggedin != null  && verified != null && verified != false  ){
      Navigator.pushNamed(context, '/navbar');
    }
    else {
      Navigator.pushNamed((context), '/welcome');
    }

  }

  @override
  void initState() {
    super.initState();
    // Start the animation when the widget is added to the tree
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });
    Future.delayed(Duration(seconds: 4),() {
      SessionCheck();
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 2), // Set the duration of the animation
        curve: Curves.ease, // Set the curve of the animation

        child: Center(
          child: AnimatedOpacity(
            duration: Duration(seconds: 2), // Set the duration of the opacity animation
            opacity: _opacity,
            child: Image.asset(
              'Assets/logo.png', // Replace with your own image path
              width: 130,
              height: 130,
            ),
          ),
        ),
      ),
    );
  }
}
