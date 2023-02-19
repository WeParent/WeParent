import 'package:flutter/material.dart';

class home_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Welcome to my app!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
