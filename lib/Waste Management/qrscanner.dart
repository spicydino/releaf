import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'WasteGuidelinesPage.dart'; // Import the guidelines page
// Import the mobile scanner package

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String qrCode = "Scan a code";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Sca")),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: (capture) {
                final scannedData = capture.barcodes.first.rawValue ?? "No data found";
                setState(() {
                  qrCode = scannedData;
                });

                // Navigate to Waste Guidelines Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WasteGuidelinesPage(binLocation: scannedData),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
