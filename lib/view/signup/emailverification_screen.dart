import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '/utils/constants.dart' as constants;

import '../login/login_screen.dart';

class EmailVerification extends StatefulWidget {
 
  const EmailVerification({super.key});
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;

  
  Future<void> _verifyOTP() async {
    if (!_formKey.currentState!.validate()) return;

 final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('Email');
    final response = await http.post(
      Uri.parse('${constants.SERVER_URL}/user/VerifyEmail'),
      body: {'OTP': _otpController.text, 'Email': email},
    );

    if (response.statusCode == 200) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.lightGreen,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Email verified successfully',
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
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pushNamed(context, '/navbar');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wrong otp, try again',
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
        title: const Text("Email verification"),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text(
                'Verify your Email',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Use the six digits sent to your email to verify your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF868686),
                ),
              ),
              SizedBox(height: 32),
              Image.asset(
                'Assets/VerifyMail.png', // replace with your own image path
                height: 260,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'OTP',
                        style: TextStyle(
                          color: Color(0xFF8A8585),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the OTP';
                          }
                          if (value.length != 6) {
                            return 'OTP should be 6 numbers only';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter OTP',
                          fillColor: Colors.white,
                          filled: true,
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
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 55,
                        width: 330,
                        child: ElevatedButton(
                          onPressed: () {
                            _verifyOTP();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFBC539F)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                          ),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
