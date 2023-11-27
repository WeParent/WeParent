import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/constants.dart' as constants;
import 'emailverification_screen.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //att
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  Future<String?> getBuildId() async {
    String? result = await PlatformDeviceId.getDeviceId;
    return result;
  }


  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final FirstName = FirstNameController.text;
    final LastName = LastNameController.text;
    final Email = EmailController.text;
    final Password = PasswordController.text;
    final url = Uri.parse('${constants.SERVER_URL}/user/register');
    try {
      // Show loading screen
      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()),
      );*/
    final buildId = await getBuildId();
      final response = await http.post(
        url,
        body: json.encode(
          {
            'FirstName': FirstName,
            'LastName': LastName,
            'Email': Email,
            'Password': Password,
            'BuildId': buildId,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
     
     if ( response.statusCode == 201 ) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.lightGreen,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Account created successfully',
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
      
       final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Email', Email);
      prefs.setBool('Verified', false);
     
      final responseData = json.decode(response.body);
      // Navigate to the next screen and pass the email as an argument
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pushNamed(
          context,'/verifywarning'
        );
      });
     }
else { 
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User already exists',
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
     catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Register error',
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
        title: const Text("Sign up"),
  
        shadowColor: Colors.grey,
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
           const  SizedBox(height: 30),
            const Column(
              children:  [
                Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
       
                  ),
                ),
                 SizedBox(height: 5),
            Text(
              "Please enter your informations",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF868686),
              ),
            ),
              ],
            ),
           
            SizedBox(height: 40),
            Form(
              //padding: const EdgeInsets.symmetric(horizontal: 20),
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'First name',
                    style: TextStyle(
                      color: Color(0xFF8A8585),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: FirstNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'John',

                   
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
                  SizedBox(height: 15),
                  const Text(
                    'Last name',
                    style: TextStyle(
                      color: Color(0xFF8A8585),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: LastNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Doe',

                    //fillColor: Colors.white,
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
                        return 'Please enter your Last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: Color(0xFF8A8585),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: EmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'example@domain.com',

                    
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
                      //regex
                      RegExp regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!regex.hasMatch(value)) {
                        return "Invalid Email!";
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  const Text(
                    'Passowrd',
                    style: TextStyle(
                      color: Color(0xFF8A8585),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: PasswordController,
                    obscureText: true,
                    style:TextStyle(fontSize: 16),
                    
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Password',
                      


                     
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
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter a password";
                      } else if (value.length < 8) {
                        return "The password must not be less than 8 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 45),
                  SizedBox(
                    height: 53,
                    width: 330,
                    child: ElevatedButton(
                      onPressed: () {
                        _submitForm();
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
                        "Sign up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
