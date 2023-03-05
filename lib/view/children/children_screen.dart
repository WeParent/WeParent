import 'package:flutter/material.dart';

import '../../model/child.dart';


class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({Key? key}) : super(key: key);

  @override
  _ChildrenScreenState createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  List<Child> myList = [    Child(        buildNumber: "9AD8X69D5Z1ADA62AE",        name: "Ahmed's iPhone"
      , status:"Activated"),
  Child(        buildNumber: "2A982D20223ADA51EE",
  name: "Ahmed's iPhone 2",
  status:"Deactivated")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[IconButton(
          icon:Icon(Icons.add),
          onPressed: (){
    Navigator.pushNamed(context, '/linkchild');
         }
          ,
        )],
        iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
        title: const Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.phonelink),
                ),
              ),
              TextSpan(text: 'Children'),
            ],
          ),
        ),
        
        backgroundColor: Colors.white,
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (BuildContext context, int index) {
          final child = myList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(

                      children: [
                        const SizedBox(width: 6),
                           const Padding(
                             padding: EdgeInsets.all(0.5),
                             child: Image(
                                image: AssetImage('Assets/device5.png'),
                                height: 90,
                                width: 80,
                                fit: BoxFit.contain,
                              ),
                           ),

                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      child.name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      softWrap: true, // allow text to wrap to next line if it's too long
                                      overflow: TextOverflow.ellipsis, // show overflow if text is too long
                                    ),
                                    SizedBox(height: 4), // add a little spacing between the texts
                                    Text(
                                      child.buildNumber,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey),
                                      softWrap: true, // allow text to wrap to next line if it's too long
                                      overflow: TextOverflow.ellipsis, // show overflow if text is too long
                                    ),
                                    SizedBox(height: 4), // add a little spacing between the texts
                                    Text(
                                      child.status,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: child.status == "Deactivated" ? Colors.red : Colors.lightGreen,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                   const SizedBox(width: 20),
                    Row(

                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          color: const Color(0xFFBC539F),
                          onPressed: () {
                            // handle view here
                          },
                        ),
                     
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
