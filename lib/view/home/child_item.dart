

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weparent/model/childcard.dart';
import 'package:weparent/view/blockedApps/BlockedApps.dart';

class ChildItem extends StatelessWidget {
  final ChildCard child;

  ChildItem(this.child);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, top: 25),
          width: 69,
          height: 69,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(child.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 95,
          left: 20,
          right: 3,
          child: Text(
            child.name,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          top: 100,
          left: 20,
          right: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlockedApps(),
                ));
              },
              child: Text('Apps'),
            ),
          ),
        ),
      ],
    );
  }
}
