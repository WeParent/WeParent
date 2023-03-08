import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import '/utils/constants.dart' as constants;

import 'package:weparent/view/ResetPassword/enterotp_screen.dart';

class EnterEmail extends StatefulWidget {
  EnterEmail({Key? key});
  @override
  State<EnterEmail> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final Email = EmailController.text;

    final url = Uri.parse('${constants.SERVER_URL}/user/OTPReset');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'Email': Email},
        ),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = json.decode(response.body);
      // Navigate to the next screen and pass the email as an argument
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.lightGreen,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'OTP has been successfully sent to your email',
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Email', Email);
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pushNamed(
          context,"/passwordreset"
        );
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'No account is registered with this email',
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
        title: const Text("Password recovery"),

        shadowColor: Colors.white,
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 35),
            SizedBox(
              height: 170,
              width: 200,
              child: Image.asset(
                'Assets/emailReset.png',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 35, right: 16),
              child: Column(
                children: [
                  const Text(
                    'Recover your password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  const Text(
                    'Please provide us with your email. You’ll receive a 4 digit code that you will need to recover your password',
                    style: TextStyle(
                      color: Color(0xff868686),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
              SizedBox(height: 60),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: EmailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'example@domain.com',
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
                    ),
                  ),
                  SizedBox(height: 80),
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 330,
                      child: ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFBC539F)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ),
                        child: Text(
                          'Send',
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
    );
  }
}
