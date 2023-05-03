import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weparent/view/navbar/navbar.dart';
import 'package:weparent/view/welcome/welcome_screen.dart';
import '../ResetPassword/enteremail_screen.dart';
import '/utils/constants.dart' as constants;

class SignIn extends StatefulWidget {
  SignIn();
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Email = _emailController.text.trim();
    final Password = _passwordController.text;

    final response = await http.post(
      Uri.parse('${constants.SERVER_URL}/user/login'),
      body: {
        'Email': Email,
        'Password': Password,
      },
    );

    if (response.statusCode == 200) {
      // Login successful, save token to local storage and navigate to home screen
      final data = jsonDecode(response.body);
      var verified = data['Verified'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Token', data['Token']);

      prefs.setString('FirstName', data['FirstName']);
      prefs.setString('LastName', data['LastName']);
      prefs.setString('ProfilePhoto', data['ProfilePhoto']);
      prefs.setString('Email', data['Email']);;
      prefs.setBool('isLoggedIn', true);
      prefs.setBool('Verified', data['Verified']);
      // Login successful, navigate to home screen
      if (verified == true) {
        Navigator.pushNamed(context, '/navbar');
      } else {
        Navigator.pushNamed(context, '/verifywarning');
      }
    } else {
      // Login failed, show an error message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 700),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Wrong informations, please try again',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
        title: const Text("Login"),
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              "Welcome back !",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Please enter your informations",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF868686),
              ),
            ),
            SizedBox(height: 70),
            Form(
              //padding: const EdgeInsets.symmetric(horizontal: 20),
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: Color(0xFF8A8585),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      //regex
                      RegExp regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!regex.hasMatch(value)) {
                        return "Invalid Email!";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: '',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFBC539F), width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFF8A8585)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xFF8A8585),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFBC539F), width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFF8A8585)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/emailReset");
                      },
                      child: const Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Color(0xFFBC539F),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  SizedBox(
                    width: 330,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFBC539F)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          width: 323,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(color: Color(0xFFBC539F), width: 2),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    "Assets/google.png", // Replace with the path to your asset image

                                    // Set the height of the image to match the text
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        10), // Add some spacing between the image and text
                                Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                    color: Color(0xFFBC539F),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
