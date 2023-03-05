import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '/utils/constants.dart' as constants;

import 'package:weparent/view/login/login_screen.dart';

class PasswordResetScreen extends StatefulWidget {

  const PasswordResetScreen({super.key});
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final OTP = _otpController.text;
    final Password = _passwordController.text;
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('Email');
    final url = Uri.parse('${constants.SERVER_URL}/user/ResetPassword');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'Email': email,
            'OTPReset': OTP,
            'Password': Password,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = json.decode(response.body);
      // Show success message

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
             duration: Duration(milliseconds: 700),
            backgroundColor: Colors.lightGreen,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your password has been successfully updated',
                  style: TextStyle(
                    fontSize: 14,
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
        // Navigate to login screen
        Future.delayed( Duration(milliseconds: 1000), () {
          Navigator.popUntil(
            context,
              ModalRoute.withName('/login')
          );
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wrong OTP, please try again',
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
        title: const Text("Password reset"),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Reset your password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Enter the code you received in the email',
                style: TextStyle(
                  color: Color(0xFF868686),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 24),
              Image(
                image: AssetImage('Assets/ResetPasswordd.png'),
                height:180,
                width: 200,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: '1234',
                  filled: true,
                  fillColor: Colors.white,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter OTP';
                  } else if (value.length != 4) {
                    return 'Please enter valid OTP';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: '********',
                  filled: true,
                  fillColor: Colors.white,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter new password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  hintText: '********',
                  filled: true,
                  fillColor: Colors.white,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter confirm password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 53,
                width: 330,
                child: ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text(
                    "Reset",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFBC539F)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
