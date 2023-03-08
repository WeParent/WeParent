
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


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
    _stopScanning();
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
    setState(() {
      _isScanning = false;
    });
  }

  void _onDetect(capture) {
    final List<Barcode> barcodes = capture.barcodes;
    final Uint8List? image = capture.image;
    if (barcodes.isNotEmpty) {
      final String? qrCode = barcodes[0].rawValue;
      debugPrint('QR found! $qrCode');
      _stopScanning();
      _showDialog(qrCode!);
    }
  }

  void _showDialog(String qrCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("QR Code"),
          content: Text("Scanned QR code: $qrCode"),

          actions: [
            TextButton(
              onPressed: () {
                _stopScanning();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
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
