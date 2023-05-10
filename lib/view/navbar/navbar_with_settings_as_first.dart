import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:weparent/view/children/children_screen.dart';
import 'package:weparent/view/controls/controls_screen.dart';
import 'package:weparent/view/home/home_screen.dart';
import 'package:weparent/view/navbar/widgets/curved_navigation_bar.dart';
import 'package:weparent/view/map/map.dart';
import 'package:weparent/view/settings/settings_screen.dart';

class NavBar2 extends StatefulWidget {
  final int initialIndex;

  const NavBar2({Key? key, this.initialIndex = 3}) : super(key: key);

  @override
  State<NavBar2> createState() => _NavBar2State();
}

class _NavBar2State extends State<NavBar2> {
  int _selectedIndex = 3;
  int _backButtonTapCount = 0;
  final List<Widget> _screens = [home_screen(), ControlsScreen(), map(), Settings()];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        -_backButtonTapCount++;
        if(_backButtonTapCount == 2) {
          SystemNavigator.pop();
          return false;
        }
        else{
          Fluttertoast.showToast(
            msg: " Press again to exit ",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,

            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,

          );
          Future.delayed(Duration(seconds: 2), () {
            _backButtonTapCount = 0;
          });
          return false;
        }
      },
      child: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: CurvedNavigationBar(
              items: const <Widget>[
                Icon(Icons.home, size: 25, color: Colors.white),
                Icon(Icons.phonelink_setup, size: 25, color: Colors.white),
                Icon(Icons.map, size: 25, color: Colors.white),
                Icon(Icons.settings, size: 25, color: Colors.white),
              ],
              color: Color(0xFFBC539F),
              buttonBackgroundColor: Color(0xFFBC539F),
            
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 350),
              index: _selectedIndex,
              onTap: _onItemTapped)),
    );
  }
}
