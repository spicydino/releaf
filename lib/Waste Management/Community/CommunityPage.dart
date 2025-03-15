import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

int ecoPoints = 0;

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<Map<String, dynamic>> reports = [];
  
  int? get likecount => null;


 void addReport(String report, String? imagePath, String location) {
  setState(() {
    String timestamp = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    int likecount;
    reports.add({
      'text': report,
      'image': imagePath,
      'location': location,
      'timestamp': timestamp,
      'likes': likecount=0,
      'comments': <String>[]
    });
    ecoPoints += 10;
  });
}


  void addSimpleReport(String report, String? imagePath) {
  setState(() {
    reports.add({'text': report, 'image': imagePath, 'comments': <String>[]});
    ecoPoints += 10; // Award eco points for reporting
  });
}


  Set<int> likedPosts = {};

void likePost(int index) {
  if (!likedPosts.contains(index)) {
    setState(() {
      reports[index]['likes'] = (reports[index]['likes'] ?? 0) + 1;
      ecoPoints += 1;
      likedPosts.add(index);
    });
  }
}

  void addComment(int index, String comment) {
    setState(() {
      reports[index]['comments'].add(comment);
    });
  }
void navigateToReportForm() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ReportFormPage(onSubmit: addReport), // Use addReport
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Color.fromARGB(255, 61, 207, 56),),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Community Reports', style: TextStyle(color: Color.fromARGB(255, 61, 207, 56),fontSize: 24,fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            icon: const Icon(Icons.eco, color: Color.fromARGB(255, 61, 207, 56),),
            onPressed: () {},
          ),
          Text('$ecoPoints', style: const TextStyle(color: Color.fromARGB(255, 61, 207, 56),fontSize: 20,fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 8,
              color: const Color(0xFF2A2A2A),
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Join the Movement!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Be part of a dedicated civilian team working selflessly to combat illegal dumping.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1DB954),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: const Text('Join a Team'),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: navigateToReportForm,
              icon: const Icon(Icons.report),
              label: const Text('Report Illegal Dumping'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Reported Dumping Activities:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) => Card(
                  color: const Color(0xFF2A2A2A),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: reports[index]['image'] != null
                            ? Image.file(File(reports[index]['image']), width: 50, height: 50, fit: BoxFit.cover)
                            : const Icon(Icons.warning, color: Colors.orange),
                        title: Text(reports[index]['text'], style: const TextStyle(color: Colors.white)),
                        subtitle: Text('${reports[index]['location']} • ${reports[index]['timestamp']}',
                            style: const TextStyle(color: Colors.white70)),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up, color: Colors.white70),
                            onPressed: () => {likePost(index), ecoPoints += 1},
                          ),
                          Text('${reports[index]['likes']} likes', style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                      for (String comment in reports[index]['comments'])
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text('- $comment', style: const TextStyle(color: Colors.white70)),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(13),
                        child: TextField(
                          onSubmitted: (text) => addComment(index, text),
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Add a comment...',
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ReportFormPage extends StatelessWidget {
  final Function(String, String?, String) onSubmit; // Updated to include location

  const ReportFormPage({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    String? imagePath;

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imagePath = pickedFile.path;
      }
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Report Illegal Dumping'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Describe the illegal dumping activity:',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter details about the dumping location and nature of the waste...',
                hintStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter the location of the dumping activity:',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: locationController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter the location (e.g., street name, landmark)...',
                hintStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Upload Photo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1DB954),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onSubmit(
                  descriptionController.text,
                  imagePath,
                  locationController.text, // Pass the location
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}