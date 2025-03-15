import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final List<String> userImages = [
    'https://imgs.search.brave.com/iE5cTnX-Z7te5CLYFg167qV31S8q7g0_uYN603skWTw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvaGQvbWlu/aW9uLWZpZ3VyZS1j/YXJ0b29uLXBmcC0w/dm1nZ3d5N3Aya3F5/NmpkLmpwZw',
    'https://imgs.search.brave.com/rPXq8YL52MUrDQ8qTGGwMKeUkGV2X_KdW01Q7AX1VGs/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWd2/My5mb3Rvci5jb20v/aW1hZ2VzL2dhbGxl/cnkvY2FydG9vbi1j/YXQtYXZhdGFyLW1h/ZGUtaW4tZm90b3It/YWktYW5pbWFsLWFu/aW1lLWF2YXRhci1j/cmVhdG9yXzIwMjMt/MDYtMjUtMDU0MjQx/X29hcHAuanBn',
    'https://imgs.search.brave.com/2bQbnkKowhmXAhmEUthosDqjxuHY1xfjsTErOMg2XTM/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzE4L2Ri/Lzg1LzE4ZGI4NTFm/MDc4OWI1ZTRiOGY1/NWU1ZmNkZGVlM2Ex/LmpwZw',
    'https://imgs.search.brave.com/toRhGqFKHqtIsrlfx0enrBXBTdsMU6InNDPL8ZlrMjY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvaGQvZWRp/dGVkLXBwZy1jYXJ0/b29uLXBmcC1jdmUx/MjY2MDRwZTk3YWt3/LmpwZw',
    'https://imgs.search.brave.com/cI5RqmE2v7WeyEUFSNZKl5SxjEQwt0pn11X7t2eCGkY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2E2L2U2/L2QyL2E2ZTZkMmZj/MDgwY2M5OTY0MzA1/ZjkwYTRjMjU4MTFh/LmpwZw',
  ];

  final List<String> userNames = [
  'Aarav Sharma',
  'Nisha Gupta',
  'Rohan Verma',
  'Priya Iyer',
  'Kabir Singh',
];


  final List<int> userPoints = [1982, 1987, 2000, 1087, 1055];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      
      body: SingleChildScrollView(
  child: ConstrainedBox(
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height,
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Leaderboard',
                style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPodium(userNames[0], userPoints[0], 3, userImages[0]),
              _buildPodium(userNames[2], userPoints[2], 1, userImages[2]),
              _buildPodium(userNames[1], userPoints[1], 2, userImages[1]),
            ],
          ),
          SizedBox(height: 20),
          _buildUserCard('Warren', 238, 'Silver', 258, userImages[3]),
          SizedBox(height: 20),
          _buildBarChart(),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: userNames.length,
            itemBuilder: (context, index) {
              return _buildLeaderboardItem(index + 1, userNames[index], userPoints[index], userImages[index]);
            },
          ),
        ],
      ),
    ),
  ),
),

    );
  }

  Widget _buildPodium(String name, int points, int rank, String imageUrl) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[800],
          child: Text(rank.toString(), style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
        SizedBox(height: 8),
        CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

        Text(name, style: TextStyle(color: Colors.white, fontSize: 18)),
        Text('$points EcoPoints', style: TextStyle(color: Colors.greenAccent, fontSize: 16)),
      ],
    );
  }

  Widget _buildUserCard(String name, int points, String level, int position, String imageUrl) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: Colors.white, fontSize: 20)),
              Text('Points: $points | Level: $level | Position: $position', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(int rank, String name, int points, String imageUrl) {
    return ListTile(
      leading: Text(rank.toString(), style: TextStyle(color: Colors.white, fontSize: 20)),
      title: Text(name, style: TextStyle(color: Colors.white)),
      trailing: Text('$points EcoPoints', style: TextStyle(color: Colors.greenAccent)),
    );
  }

  Widget _buildBarChart() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                          return Text(value.toString(), style: TextStyle(color: Colors.white));
                        }),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                          return Text(value.toString(), style: TextStyle(color: Colors.white));
                        }),
                      ),
                    ),
      
            borderData: FlBorderData(show: false),
            barGroups: userPoints.asMap().entries.map((entry) {
              int index = entry.key;
              int points = entry.value;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: points.toDouble(),
                    color: Colors.greenAccent,
                    width: 20,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
