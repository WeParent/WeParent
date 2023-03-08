

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weparent/view/signup/emailverification_screen.dart';
import 'dart:convert';
import '/utils/constants.dart' as constants;

import '../login/login_screen.dart';

class EmailVerificationWarning extends StatefulWidget {
  const EmailVerificationWarning({super.key});
  @override
  _EmailVerificationWarningScreenState createState() =>
      _EmailVerificationWarningScreenState();
}

class _EmailVerificationWarningScreenState
    extends State<EmailVerificationWarning> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 68),
              const Text(
                'Please verify your Email',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 55.0),
                child: Image.asset(
                  'Assets/warning.png', // replace with your own image path
                  height: 250,

                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 32),
              const Text(
                'In order to access We Parent and benefit from our protection features, youn need to verify your E-mail. We have sent you an email with a unique code you need to retrieve. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF868686),
                ),
              ),
              SizedBox(height: 120),
              SizedBox(
                height: 55,
                width: 330,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context,"/verifyemail");
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFBC539F)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', ModalRoute.withName('/welcome'));
                      },
                      child: const Text(
                        "Leave",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xFFBC539F),
                          
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
