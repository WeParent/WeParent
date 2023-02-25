// ignore_for_file: unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weparent/models/user.dart';
import 'package:weparent/utils/consts.dart';
import '../../view_model/userViewModel.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  final UserProfileViewModel _userProfileViewModel;
  final String accessToken;

  const EditProfilePage({
    Key? key,
    required UserProfileViewModel userProfileViewModel,
    required this.accessToken,
  })  : _userProfileViewModel = userProfileViewModel,
        super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final firstName = FirstNameController.text;
    final lastName = LastNameController.text;
    final email = EmailController.text;
    final url = Uri.parse('$BASE_URL/user/update');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'FirstName': firstName,
            'LastName': lastName,
            'Email': email,
          },
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': widget.accessToken, // Use widget.accessToken here
        },
      );
      final responseData = json.decode(response.body);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Updated Successfully')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    widget._userProfileViewModel.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purpleAccent,
                Colors.deepPurple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: widget._userProfileViewModel.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final user = User.fromJson(snapshot.data!);

            return Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Update your account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Form(
                      //padding: const EdgeInsets.symmetric(horizontal: 20),
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
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
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFBC539F), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(0xFF8A8585)),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
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
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFBC539F), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(0xFF8A8585)),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Last name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
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
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFBC539F), width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(0xFF8A8585)),
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
                          SizedBox(height: 20),
                          SizedBox(
                            height: 53,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFFBC539F)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Divider(
                                  color: Color(0xFFBC539F),
                                  thickness: 1,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Color(0xFFBC539F),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Failed to load profile'),
            );
          }
        },
      ),
    );
  }
}
