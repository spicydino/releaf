import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'WasteGuidelinesPage.dart'; // Import the guidelines page

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String qrCode = "Scan a code";
  bool _isNavigating = false; // Prevent multiple navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        title: Text("QR Scanner", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Text(
              "Scan a QR Code",
              style: TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // Centered Scanner
            Container(
              height: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
              width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.greenAccent, width: 3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MobileScanner(
                  onDetect: (capture) {
                    if (!_isNavigating) {
                      final scannedData = capture.barcodes.first.rawValue ?? "No data found";
                      setState(() {
                        qrCode = scannedData;
                        _isNavigating = true; // Lock navigation
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WasteGuidelinesPage(binLocation: scannedData),
                        ),
                      ).then((_) {
                        setState(() {
                          _isNavigating = false; // Unlock on return
                        });
                      });
                    }
                  },
                ),
              ),
            ),
            
            SizedBox(height: 20),
            Text(
              qrCode,
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
