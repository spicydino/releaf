import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:releaf/Waste%20Management/Community/CommunityPage.dart';
import 'package:releaf/WasteManagementdastboard/WasteManagementDashboard.dart';
import 'package:releaf/profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Card
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/Images/forest.jpg'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
                height: 220,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Actions and Implementation",
                        style: GoogleFonts.roboto(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          //tracker for changes


                        },
                        icon: const Icon(Icons.arrow_forward, size: 18),
                        label: const Text("Start"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/Images/waste.jpg'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Container(
  decoration: BoxDecoration(
    color: Colors.black.withOpacity(0.6), // Semi-transparent dark background
    borderRadius: BorderRadius.circular(8), // Rounded corners
  ),
  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add some padding
  child: Text(
    "Manage Aapla Waste",
    style: GoogleFonts.roboto(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
),

    const SizedBox(height: 5),
    Align(
      alignment: Alignment.center,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
        context,
          MaterialPageRoute(builder: (context) => Wastemanagementdashboard()),
      );
        },
        icon: const Icon(Icons.arrow_forward, size: 18),
        label: const Text("Start"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    ),
    
    Text(
      "Aapla kachra aapli zawabdari",
      style: GoogleFonts.roboto(
        fontSize: 16,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
    ),
    
    const SizedBox(height: 20),
    
  ],
),

              ),


              SizedBox(height: 20),

              // CO2 Footprint Card
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      "Your CO₂ Footprint",
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 12,
                      animation: true,
                      percent: 0.8,
                      center: Text(
                        "80.4%",
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: Colors.orange,
                      backgroundColor: Colors.grey.shade800,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "7h 30m\nTime emitted today",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Icon(Icons.arrow_drop_up, color: Colors.green, size: 28),
                    Text(
                      "Slightly better than yesterday",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                            MaterialPageRoute(builder: (context) => UserProfile()),
                        );
                    },
                    icon: const Icon(Icons.task, color: Colors.white),
                    label: const Text("Task of the day"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                            context,
                              MaterialPageRoute(builder: (context) => CommunityPage()),
                          );
                    },
                    icon: const Icon(Icons.explore, color: Colors.white),
                    label: const Text("Explore community"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildStatCard("Waste Segregation", "72%", 0.72, Colors.blue),
                      buildStatCard("Recycling Rate", "65%", 0.65, Colors.green),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildStatCard("Reporting Response", "54%", 0.54, Colors.orange),
                      buildStatCard("User Engagement", "81%", 0.81, Colors.lightBlue),
                    ],
                  ),
                ],
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildStatCard(String title, String percentage, double value, Color color) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF1C2A35),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 50.0,    // Reduced radius for consistency
            lineWidth: 8.0,
            animation: true,
            percent: value,
            center: Text(
              percentage,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: color,
            backgroundColor: Colors.grey[800]!,
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Text(
            getSubtitle(title),
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}


  String getSubtitle(String title) {
    switch (title) {
      case "Waste Segregation":
        return "Current waste segregation rate in covered areas";
      case "Recycling Rate":
        return "Percentage of waste successfully recycled";
      case "Reporting Response":
        return "Issues resolved within 48 hours";
      case "User Engagement":
        return "Active participation ";
      default:
        return "";
    }
  }
