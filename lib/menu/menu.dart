import 'package:flutter/material.dart';
import 'package:releaf/Waste%20Management/Community/CommunityPage.dart';
import 'package:releaf/dashboard/dashboard.dart';
import 'package:releaf/leaderboard/leaderboard.dart';
import 'package:releaf/profile/profile.dart';
import 'package:releaf/widgets/chat_widget.dart';

class MenuPage extends StatefulWidget {

  MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('BinIt'),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color.fromARGB(255, 24, 175, 36)),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF1B5E20),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF2E7D32),
                ),
                child: Center(
                  child: Text(
                    'BinIt',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              _buildDrawerItem(context, Icons.home, 'Dashboard', '/dashboard'),
              _buildDrawerItem(context, Icons.leaderboard, 'Leaderboard', '/leaderboard'),
              _buildDrawerItem(context, Icons.history, 'Activity Log', '/activity'),
              _buildDrawerItem(context, Icons.account_circle, 'My Profile', '/profile'),
              _buildDrawerItem(context, Icons.info, 'About', '/about'),
              _buildDrawerItem(context, Icons.contact_support, 'Support', '/support'),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'FAQ • Contact Us',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Welcome to BinIt!',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

      Widget _buildDrawerItem(BuildContext context, IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _getPageByRoute(route)),
        );
      },
    );
  }



      Widget _getPageByRoute(String route) {
        try {
          switch (route) {
          case '/dashboard':
            return Dashboard();
          case '/leaderboard':
            return LeaderboardScreen();
          case '/activity':
            return CommunityPage();
          case '/profile':
            return UserProfile();
          case '/about':
            return Dashboard();
          case '/support':
            return ChatWidget();
          default:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Page Not Found"),
              ),
              body: const Center(
                child: Text("Page not found. Please try again."),
              ),
            );
        }
      } catch (e) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Error"),
          ),
          body: Center(
            child: Text("Error loading page: $e"),
          ),
        );
      }
    }
}