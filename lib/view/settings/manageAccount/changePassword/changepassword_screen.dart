import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/utils/constants.dart' as constants;


class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //att
  TextEditingController OldPasswordController = TextEditingController();
  TextEditingController NewPasswordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();


  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() || NewPasswordController.text != ConfirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Passwords do not match',
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
  else {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    final token = prefs.getString('Token');

    final oldpw = OldPasswordController.text;
    final newpw = NewPasswordController.text;
    final confirmpw = ConfirmPasswordController.text;

    final url = Uri.parse('${constants.SERVER_URL}/user/updatePassword');
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            'oldPassword': oldpw,
            'newPassword': newpw,
    
          },
        ),
        headers: {'Content-Type': 'application/json',
        'Authorization': '$token'},
      );
     
     if ( response.statusCode == 200 ) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.lightGreen,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Password updated successfully',
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
      
       
     
      
      // Navigate to the next screen and pass the email as an argument
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pop(context);
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
                'Password update error',
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
                'Password update error',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar :AppBar(
     
        
        iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
        title: const Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.password),
                ),
              ),
              TextSpan(text: 'Change password'),
            ],
          ),
        ),
        

        centerTitle: true,
        titleSpacing: 0.0,

        foregroundColor: const Color(0xFFBC539F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 25),
          Image.asset("Assets/casual-life-3d-lock.png",width: 120,)
          ,SizedBox(height: 30,),
            const Text(
              "Please provide us with your old password and new password",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF868686),
              ),
            ),
            SizedBox(height: 20),
            Form(
              //padding: const EdgeInsets.symmetric(horizontal: 20),
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 15),
                  const Text(
                    'Old password',
                    style: TextStyle(
                      color: Color(0xFF8A8585),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: OldPasswordController,
                    obscureText: true,
                    style:TextStyle(fontSize: 16),
                    
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Old password',
                      

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
                  const SizedBox(height: 15),
                  const Text(
                    'New password',
                    style: TextStyle(
                      color: Color(0xFF8A8585),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: NewPasswordController,
                    obscureText: true,
                    style:TextStyle(fontSize: 16),
                    
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'New password',
                      

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
                  SizedBox(height: 15),
                  const Text(
                    'Confirm new password',
                    style: TextStyle(
                      color: Color(0xFF8A8585),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: ConfirmPasswordController,
                    obscureText: true,
                    style:TextStyle(fontSize: 16),
                    
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Password',
                      

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
                  SizedBox(height: 40),
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
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
             
                 SizedBox(height: 30)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
