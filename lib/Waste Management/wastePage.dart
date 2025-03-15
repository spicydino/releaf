import 'package:flutter/material.dart';
import 'package:releaf/Waste%20Management/Community/CommunityPage.dart';

class WastePage extends StatelessWidget {
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
                // Navigate to QR scanning mechanism
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScanPage()),
                );
              },
              child: Text('Scan QR Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to community building page
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

class QRScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scan'),
      ),
      body: Center(
        child: Text('QR Scanning Mechanism Here'),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: WastePage(),
  ));
}