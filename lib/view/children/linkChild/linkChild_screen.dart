

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class LinkChildScreen extends StatelessWidget {
  LinkChildScreen({Key? key}) : super(key: key);
  final pages = [
    PageViewModel(
      pageColor: Colors.white,
      bubbleBackgroundColor: Color(0xFFBC539F),
      body: Column(children: [
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text: "Just a few steps..\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFBC539F),
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text:
                      "\n In order to link your child's device and access our features, Please follow the next steps precisely",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        )
      ]),
      bodyTextStyle: const TextStyle(fontSize: 18, color: Colors.black),
      mainImage: Image.asset(
        'Assets/kid.png',
        height: 350.0,
        width: 350.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Color(0xFFBC539F),
      bubbleBackgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: "Download our Junior app\n",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text:
                        '\n First, you will need to download the We Parent Junior app from the app store on your child device',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bodyTextStyle: const TextStyle(fontSize: 18, color: Colors.black),
      mainImage: Image.asset(
        'Assets/download.png',
        height: 350.0,
        width: 350.0,
        alignment: Alignment.centerRight,
      ),
    ),
    PageViewModel(
      bubbleBackgroundColor: Color(0xFFBC539F),
      pageColor: Colors.white,
      body: Column(children: [
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text: "Get your child's QR\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFBC539F),
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text:
                      "\n Open the WeParent Junior app on your child device, navigate to 'Settings' and then to 'QR code' ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        )
      ]),
      bodyTextStyle: const TextStyle(fontSize: 18, color: Colors.black),
      mainImage: Image.asset(
        'Assets/getqr.png',
        height: 350.0,
        width: 350.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      bubbleBackgroundColor: Colors.white,

      pageColor: Color(0xFFBC539F),
      body: Column(children: [
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text: "Scan child QR code\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text:
                      "\n Scan the QR code, we'll handle the rest.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ],
            ),

          ),

        ),
        SizedBox(height: 35),
        SizedBox(
          width: 150,
          height: 35,
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/scan');
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                ),
                child: const Text(
                  "Scan",
                  style: TextStyle(
                      color: Color(0xFFBC539F),
                      fontSize: 16,
                      ),
                ),
              );
            }
          ),
        ),
      ]),
      bodyTextStyle: const TextStyle(fontSize: 18, color: Colors.black),
      mainImage: Image.asset(
        'Assets/scanqr.png',
        height: 350.0,
        width: 350.0,
        alignment: Alignment.center,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
          title: const Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.phonelink_setup),
                  ),
                ),
                TextSpan(text: 'Link a child'),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          titleSpacing: 0.0,
          foregroundColor: const Color(0xFFBC539F),
        ),
        body: Builder(
            builder: (context) => IntroViewsFlutter(
                  pages,
                  showNextButton: false,
                  skipText: Text("Skip"),
                  nextText: Text("Next"),
                  backText: Text("Back"),
                  doneText: Text(""),
                  showBackButton: false,

                  pageButtonTextStyles: const TextStyle(
                    color: Colors.black38,
                    fontSize: 17.0,
                  ),
                )));
  }
}
