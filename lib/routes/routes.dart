import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:weparent/view//ResetPassword/enteremail_screen.dart';
import 'package:weparent/view//login/login_screen.dart';
import 'package:weparent/view//signup/signup_screen.dart';
import 'package:weparent/view//welcome/welcome_screen.dart';
import 'package:weparent/view/children/children_screen.dart';
import 'package:weparent/view/controls/controls_screen.dart';
import 'package:weparent/view/home/home_screen.dart';
import 'package:weparent/view/navbar/navBar.dart';
import 'package:weparent/view/children/linkChild/linkChild_screen.dart';
import 'package:weparent/view/children/linkChild/scanQR/scan_screen.dart';
import 'package:weparent/view/navbar/navbar_with_settings_as_first.dart';
import 'package:weparent/view/settings/manageAccount/changePassword/changepassword_screen.dart';
import '../view/ResetPassword/enterotp_screen.dart';
import '../view/settings/manageAccount/manageaccount_screen.dart';
import '../view/settings/manageAccount/editAccount/editprofile_screen.dart';
import '../view/signup/emailverification_screen.dart';
import '../view/signup/emailverificationwarning_screen.dart';
import '../view/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/welcome': (context) => WelcomeScreen(),
  '/':(context) => SplashScreen(),
  '/login': (context) => SignIn(),
  '/register': (context) => SignUp(),
  '/emailReset': (context) => EnterEmail(),
  '/home':(context) => home_screen(),
   '/verifyemail':(context) => EmailVerification(),
  '/verifywarning':(context) =>  EmailVerificationWarning(),
  '/passwordreset':(context) => PasswordResetScreen(),
  '/navbar':(context) => NavBar(),
  '/children':(context) => ChildrenScreen(),
  '/controls':(context) => ControlsScreen(),
    '/navbar2':(context) => const NavBar2(),
  '/scan': (context) => ScanScreen(),
  '/linkchild': (context) => LinkChildScreen(),
  '/manageaccount':(context) => ManageAccount(),
  '/editprofile':(context) => EditProfile(),
  '/changepassword':(context) => ChangePassword()
};
