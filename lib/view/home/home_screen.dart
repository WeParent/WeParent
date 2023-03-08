import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weparent/model/child.dart';
import 'package:weparent/model/childcard.dart';
import 'package:weparent/view/blockedApps/BlockedApps.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:weparent/view/home/child_item.dart';


class home_screen extends StatelessWidget {

  final List<ChildCard> children = [
    ChildCard(
      image: 'Assets/ahmed.png',
      name: 'Yassin',
    ),
    ChildCard(image: 'Assets/yassin.png', name: 'Ahmed'),
    ChildCard(image: 'Assets/salma.png', name: 'Salma'),
  ];
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
                  child: Icon(Icons.home_filled),
                ),
              ),
              TextSpan(text: 'Home'),
            ],
          ),
        ),
       
          automaticallyImplyLeading: false,
        foregroundColor: const Color(0xFFBC539F),
        centerTitle: true,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 38, 20, 0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFBC539F), width: 1),
              ),
              child: Icon(Icons.person_add_alt_1_rounded),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              children: children.map((child) => ChildItem(child)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
