// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:releaf/widgets/carbon_stats_widget.dart';
import 'package:releaf/widgets/chat_widget.dart';
import 'package:releaf/screens/emission_entry_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Carbon Stats Widget (approximately 40% of screen)
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.all(16),
                child: CarbonStatsWidget(),
              ),
              SizedBox(height: 16),
              TextButton.icon(
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EmissionEntryScreen()),
    );
  },
  icon: Icon(
    Icons.add,
    color: Colors.green.shade800,
  ),
  label: Text(
    'Add Manual Input',
    style: TextStyle(
      color: Colors.green.shade800,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
  style: TextButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    backgroundColor: Colors.green.shade100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
),

              SizedBox(height: 16),
              // Chat Widget (approximately 60% of screen)
              Container(
                height: MediaQuery.of(context).size.height * 0.5, // Define height for the chat section
                padding: EdgeInsets.all(16),
                child: ChatWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
