
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../model/child.dart';
import '/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;


class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  MobileScannerController? _controller;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController();
    _startScanning();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startScanning() {
    _controller?.start();
    setState(() {
      _isScanning = true;
    });
  }

  void _stopScanning() {
    _controller?.stop();
    if (mounted) {
      setState(() {
        _isScanning = false;
      });
    }

  }

  void _onDetect(capture) {
    final List<Barcode> barcodes = capture.barcodes;
    final Uint8List? image = capture.image;
    if (barcodes.isNotEmpty) {
      final String? qrCode = barcodes[0].rawValue;
      debugPrint('QR found! $qrCode');
      _stopScanning();
      linkChild(qrCode!);
     // _showDialog(qrCode!);
      


      
    }
  }

  void _showDialog(String qrCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("SUCCESS", textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFBC539F)
            )),
          ),
          titleTextStyle: const TextStyle(


          ),
          content: Text(
            "Child device linked successfully",
            textAlign: TextAlign.center,
            style: TextStyle(
            
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      },
    );
  }

linkChild(String qrCode) async {

 SharedPreferences prefs = await SharedPreferences.getInstance();
    var tok = prefs.getString("Token");


   try {
      final response = await http.post(
        Uri.parse('${constants.SERVER_URL}/parent/'),
        body: {
          'BuildId': qrCode.toString(),
        },
        headers: {
          'Authorization': '$tok',
        },
      ); 

       if (response.statusCode == 200) {
         _showDialog(qrCode);
        Future.delayed(Duration(seconds: 1), () {
           Navigator.pushNamedAndRemoveUntil(
               context, '/navbar', ModalRoute.withName('/navbar'));
         });
       }


       else {

          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            
            duration: Duration(milliseconds: 700),
            backgroundColor: Colors.redAccent,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Child already linked or invalid QR code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.error_outline_rounded,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );

          Navigator.pop(context);
       }
   } catch(error) {
     print(error);

   }
}




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
                  child: Icon(Icons.qr_code),
                ),
              ),
              TextSpan(text: 'Scan QR'),
            ],
          )
        ),
        centerTitle: true,
        titleSpacing: 0.0,
        foregroundColor: const Color(0xFFBC539F),
      )
      ,
      body: MobileScanner(
        controller: _controller!,
        onDetect: _onDetect,
      ),
    );
  }
}
