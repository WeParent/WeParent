import 'dart:convert';
import '/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../model/child.dart';


class AppsScreen extends StatefulWidget {
  const AppsScreen({Key? key}) : super(key: key);

  @override
  _AppsScreenState createState() => _AppsScreenState();


  
}

class _AppsScreenState extends State<AppsScreen> {

  List<String> _myList = [];

 Future<void> _loadChildren() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tok = prefs.getString("Token");
    var buildid =  prefs.getString("CHILDBUILDID");

    try {
      final response = await http.post(
        Uri.parse('${constants.SERVER_URL}/application/$buildid'),
      );
      print("RESPONSE");
      print(response.body);
      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);
        print(data);
        for (var jsonMap in data) {
          var name = jsonMap['Name'];
          setState(() {
            _myList.add(name);
          });

        }
      }
    }
    catch(err) {
       print(err);
    }

  }


 @override
  void initState() {
    // TODO: implement initState
   super.initState();
   _loadChildren();


  }


  @override
  void didUpdateWidget(AppsScreen oldWidget) {
    _loadChildren();
    super.didUpdateWidget(oldWidget);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
   
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
        title: const Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.android),
                ),
              ),
              TextSpan(text: 'Applications'),
            ],
          ),
        ),
        

        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        itemCount: _myList.length,
        itemBuilder: (BuildContext context, int index) {
          final name = _myList[index];
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
                        const SizedBox(width: 25,height: 25),
                           const Padding(
                             padding: EdgeInsets.all(0.5),
                             child: Image(
                                image: AssetImage('Assets/android.png'),
                                height: 60,
                                width:60,
                                fit: BoxFit.contain,
                              ),
                           ),
                        SizedBox(width: 25),
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      softWrap: true, // allow text to wrap to next line if it's too long
                                      overflow: TextOverflow.clip, // show overflow if text is too long
                                    ),
                                    SizedBox(height: 4), // add a little spacing between the texts
                                   // add a little spacing between the texts
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                   const SizedBox(width: 20),

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
