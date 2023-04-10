import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:weparent/view/children/children_screen.dart';
import 'package:weparent/view/home/home_screen.dart';
import 'package:weparent/view/navbar/widgets/curved_navigation_bar.dart';
import 'package:weparent/view/map/map.dart';
import 'package:weparent/view/settings/settings_screen.dart';

class NavBar extends StatefulWidget {
   final int initialIndex;
  const NavBar({Key? key,this.initialIndex = 0}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  int _backButtonTapCount = 0;
  final List<Widget> _screens = [home_screen(), const ChildrenScreen(), map(), Settings()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


 @override void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // ignore: dead_code
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
                Icon(Icons.phonelink, size: 25, color: Colors.white),
                Icon(Icons.map, size: 25, color: Colors.white),
                Icon(Icons.settings, size: 25, color: Colors.white),
              ],
              color: Color(0xFFBC539F),
              index: _selectedIndex,
              buttonBackgroundColor: Color(0xFFBC539F),
           
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 350),
              onTap: _onItemTapped)),
    );
  }
}
