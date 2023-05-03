import 'dart:convert';
import '/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../model/child.dart';


class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({Key? key}) : super(key: key);

  @override
  _ChildrenScreenState createState() => _ChildrenScreenState();


  
}

class _ChildrenScreenState extends State<ChildrenScreen> {

  List<Child> _myList = [];

 Future<void> _loadChildren() async {
    final List<Child> formattedList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tok = prefs.getString("Token");

    try {
      final response = await http.get(
        Uri.parse('${constants.SERVER_URL}/parent/'),
        headers: {
          'Authorization': '$tok',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var jsonMap in data) {
          Child child = Child.fromJson(jsonMap);
          setState(() {
            _myList.add(child);
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
  void didUpdateWidget(ChildrenScreen oldWidget) {
    _loadChildren();
    super.didUpdateWidget(oldWidget);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
   
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
        
    
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        itemCount: _myList.length,
        itemBuilder: (BuildContext context, int index) {
          final child = _myList[index];
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
