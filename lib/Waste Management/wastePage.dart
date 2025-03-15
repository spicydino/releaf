import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:releaf/Waste%20Management/Community/CommunityPage.dart';
import 'package:releaf/Waste%20Management/qrscanner.dart';

void main() {
  runApp(MaterialApp(
    home: WastePage(),
  ));
}

class WastePage extends StatelessWidget {
  const WastePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waste Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScannerPage()),
                );
              },
              child: Text('Scan QR Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityPage()),
                );
              },
              child: Text('Build a Community'),
            ),
          ],
        ),
      ),
    );
  }
}



