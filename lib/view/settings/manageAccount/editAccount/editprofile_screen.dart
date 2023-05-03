import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weparent/routes/routes.dart';

import 'package:weparent/view/navbar/navbar.dart';
import '/utils/constants.dart' as constants;

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //att
  final picker = ImagePicker();
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  String _firstname = '';
  String _lastname = '';
  String _email = '';
  String _photo = '';

  XFile? _imageFile;

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstname = prefs.getString('FirstName')!;
      _lastname = prefs.getString('LastName')!;
      _email = prefs.getString('Email')!;
      _photo = prefs.getString('ProfilePhoto')!;
    });
  }

  Future _getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  void dispose() {
    FirstNameController.dispose();
    LastNameController.dispose();
    EmailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadData().then((_) {
      FirstNameController.text = _firstname.toString();
      LastNameController.text = _lastname;
      EmailController.text = _email;
      
      _photo = _photo;
  });
  }
  Future<void> _changephoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tok = prefs.getString("Token");

    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('${constants.SERVER_URL}/user/updatePhoto'),
    );
    request.headers['Authorization'] = tok!;

      request.files.add(
        await http.MultipartFile.fromPath(
          'ProfilePhoto',
          _imageFile!.path,
        ),
      );
    

    final response = await request.send();
     await for (var chunk in response.stream.transform(utf8.decoder)) {
    final data = jsonDecode(chunk);
   prefs.setString("ProfilePhoto", data['newURL']);
  }
    
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if(_imageFile != null) {
      
     _changephoto();
    }
    else {
      print('no new image');
     }
    final FirstName = FirstNameController.text;
    final LastName = LastNameController.text;
    final Email = EmailController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tok = prefs.getString("Token");

    try {
      final response = await http.put(
        Uri.parse('${constants.SERVER_URL}/user/update'),
        body: {
          'FirstName': FirstName,
          'LastName': LastName,
          'Email': Email,
        },
        headers: {
          'Authorization': '$tok',
        },
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            
            duration: Duration(milliseconds: 700),
            backgroundColor: Colors.lightGreen,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Changes saved successfully',
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
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        
        await prefs.setString('Email', data['Email']);
        await prefs.setString('FirstName', data['FirstName']);
        await prefs.setString('LastName', data['LastName']);
        

        // Navigate to the next screen and pass the email as an argument
        Future.delayed(Duration(milliseconds: 1000), () {
       
       
  Navigator.pushNamedAndRemoveUntil(context,'/navbar2',ModalRoute.withName('/navbar'));
  //  Navigator.pop(context, '/navbar2');


        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
             duration: Duration(milliseconds: 700),
            backgroundColor: Colors.redAccent,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Error saving changes',
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
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           duration: Duration(milliseconds: 700),
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Error saving changes',
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
          title: const Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.person_pin),
                  ),
                ),
                TextSpan(text: 'Edit account information'),
              ],
            ),
          ),

          foregroundColor: const Color(0xFFBC539F),
          centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  _getImage();
                },
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 7.0),
                    child: Container(
                        child: _imageFile != null
                            ? CircleAvatar(
                                radius: 90,
                                backgroundColor: Colors.white,
                                foregroundImage:
                                    FileImage(File(_imageFile!.path)),
                              )
                            : CircleAvatar(
                                radius: 90,
                                backgroundColor: Colors.white,
                                foregroundImage: NetworkImage(_photo),
                              )))),
            GestureDetector(
              onTap: _getImage,
              child: const Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.edit, color: Color(0xFFBC539F)),
                      ),
                    ),
                    TextSpan(
                        text: 'Change',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFBC539F))),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              "You can edit your information by changing the fields below and saving",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF868686),
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                  SizedBox(height: 30),
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
