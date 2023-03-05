import 'package:flutter/material.dart';

import '../login/login_screen.dart';
import '../signup/signup_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Image.asset(
              "Assets/firstpage.png",
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            SizedBox(height: 20),
            Text(
              "Welcome!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Let us help you with your journey! Join the \n community",
              style: TextStyle(
                color: Color(0xFF868686),
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 330,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the sign in screen when the button is pressed
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Text(
                      "Already a member",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFBC539F)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 330,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: Text(
                      "Become a member",
                      style: TextStyle(
                        color: Color(0xFFBC539F),
                        fontSize: 18,
                      ),
                    ),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Color(0xFFBC539F),width: 2),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
