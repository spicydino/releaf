// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:releaf/widgets/carbon_stats_widget.dart';
import 'package:releaf/widgets/chat_widget.dart';
import 'package:releaf/screens/emission_entry_screen.dart';

import '../screens/emission_entry_screen.dart'; // Add this import

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BinIt Carbon Tracker'),
        backgroundColor: Colors.green.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EmissionEntryScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Carbon Stats Widget (approximately 40% of screen)
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: EdgeInsets.all(16),
              child: CarbonStatsWidget(),
            ),
            
            // Chat Widget (approximately 60% of screen)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: ChatWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}