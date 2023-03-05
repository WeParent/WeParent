import 'package:flutter/material.dart';
import 'package:weparent/view//signup/signup_screen.dart';
import 'package:weparent/routes/routes.dart';
import 'package:weparent/view/blockedApps/blockedApps.dart';
import 'package:weparent/view/home/home_screen.dart';
import 'package:weparent/view/navbar/navbar.dart';

import 'view//ResetPassword/enterotp_screen.dart';
import 'view//login/login_screen.dart';
import 'view//welcome/welcome_screen.dart';
import 'view/ResetPassword/enteremail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //home: SignIn(),
      //home: SignUp(),
      //home: EnterEmail()
      routes: routes,
    );
  }
}
