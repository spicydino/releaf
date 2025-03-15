import 'package:flutter/material.dart';
import 'package:releaf/Home_page.dart';
import 'package:releaf/Waste Management/wastePage.dart';
import 'package:releaf/dashboard/dashboard.dart';
import 'package:releaf/screens/dashboard_screen.dart';
import 'package:releaf/screens/eco_chat_screens.dart';
import 'package:releaf/leaderboard/leaderboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Dashboard(),
    LeaderboardScreen(),
    DashboardScreen(),
    Center(child: Text('Upcoming', style: TextStyle(fontSize: 24, color: Colors.white))),
    Center(child: Text('Profile', style: TextStyle(fontSize: 24, color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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

      // Display the selected page
      body: _pages[_currentIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(150, 25, 25, 25), // Semi-transparent black
          borderRadius: BorderRadius.circular(30), // Circular corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4), // Uplifted shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home, 'Home', 0),
              _buildBottomNavItem(Icons.leaderboard, 'Leaderboard', 1),
              _buildBottomNavItem(Icons.chat_bubble, 'ChatBox', 2),
              _buildBottomNavItem(Icons.upcoming, 'Upcoming', 3),
              _buildBottomNavItem(Icons.person, 'Profile', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: _currentIndex == index
                ? const Color.fromARGB(255, 24, 175, 36) // Selected color
                : Colors.grey, // Unselected color
          ),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index
                  ? const Color.fromARGB(255, 24, 175, 36) // Selected color
                  : Colors.grey, // Unselected color
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
