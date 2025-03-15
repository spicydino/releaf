import 'package:flutter/material.dart';
import 'package:releaf/Waste%20Management/Community/CommunityPage.dart';
import 'package:releaf/Waste%20Management/qrscanner.dart';

class Wastemanagementdashboard extends StatefulWidget {
  const Wastemanagementdashboard({super.key});

  @override
  State<Wastemanagementdashboard> createState() => _WastemanagementdashboardState();
}

class _WastemanagementdashboardState extends State<Wastemanagementdashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leadingWidth: 150,
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 20),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  'assets/Images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'BinIt',
              style: TextStyle(
                color: Color.fromARGB(255, 24, 175, 36),
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
            color: const Color.fromARGB(255, 24, 175, 36),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: const Color.fromARGB(255, 24, 175, 36),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavigationCard(
                  context,
                  'QR Scanner',
                  Icons.qr_code_scanner,
                  Colors.green,
                  QRScannerPage(),
                ),
                _buildNavigationCard(
                  context,
                  'Community Report',
                  Icons.bar_chart,
                  Colors.blue,
                  CommunityPage(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildCommunityCard('NSS', 'assets/Images/nss.jpg'),
                  _buildCommunityCard('Swach Amhi', 'assets/Images/community.jpg'),
                  _buildCommunityCard('EcoWarriors', 'assets/Images/community.jpg'),
                  _buildCommunityCard('Mumbai Heroes', 'assets/Images/community.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context, String title, IconData icon, Color color,Widget route) {
    return GestureDetector(
      onTap: () => Navigator.push(
  context, 
  MaterialPageRoute(builder: (context) => route),
),

      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommunityCard(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black.withOpacity(0.6),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Join Us',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}