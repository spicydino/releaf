import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class WasteGuidelinesPage extends StatefulWidget {
  final String binLocation;

  WasteGuidelinesPage({required this.binLocation});

  @override
  _WasteGuidelinesPageState createState() => _WasteGuidelinesPageState();
}

class _WasteGuidelinesPageState extends State<WasteGuidelinesPage> {
  TextEditingController reportController = TextEditingController();
  List<XFile> images = [];
  List<Map<String, dynamic>> reports = [];
  Set<int> likedReports = {}; // Track liked reports

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        images.addAll(pickedImages);
      });
    }
  }

  void _submitReport() {
    if (reportController.text.isEmpty && images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please add a report or images.")),
      );
      return;
    }

    setState(() {
      reports.add({
        "text": reportController.text,
        "imagePaths": images.map((img) => img.path).toList(),
        "likes": 0,
        "comments": <String>[],
      });
      reportController.clear();
      images.clear();
    });
  }

  void _addComment(int index, String comment) {
    if (comment.trim().isEmpty) return;
    setState(() {
      reports[index]["comments"].add(comment);
    });
  }

  void _incrementLike(int index) {
    if (!likedReports.contains(index)) {
      setState(() {
        reports[index]["likes"]++;
        likedReports.add(index);
      });
    }
  }

  void _showCommentBottomSheet(BuildContext context, int index) {
    TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true, // ✅ Allows keyboard to push content up
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // ✅ Adjust for keyboard
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: "Add a comment",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _addComment(index, commentController.text);
                  Navigator.pop(context);
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Waste Guidelines", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bin Location: ${widget.binLocation}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.greenAccent),
            ),
            SizedBox(height: 10),

            // Report Input
            TextField(
              controller: reportController,
              decoration: InputDecoration(
                labelText: "Add a report",
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(color: Colors.white),
              maxLines: 3,
            ),
            SizedBox(height: 10),

            // Image Preview (Before Submitting)
            Wrap(
              children: images.map((image) {
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Image.file(File(image.path), width: 60, height: 60, fit: BoxFit.cover),
                );
              }).toList(),
            ),
            SizedBox(height: 10),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.image, color: Colors.black),
                  label: Text("Add Images", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _submitReport,
                  icon: Icon(Icons.send, color: Colors.black),
                  label: Text("Submit Report", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Reports Section
            Expanded(
              child: reports.isEmpty
                  ? Center(
                      child: Text(
                        "No reports yet",
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey[900],
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reports[index]["text"],
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),

                                // Display images from reports
                                if ((reports[index]["imagePaths"] as List<String>).isNotEmpty)
                                  SizedBox(
                                    height: 80,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: (reports[index]["imagePaths"] as List<String>).map((imagePath) {
                                        return Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Image.file(
                                            File(imagePath),
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(Icons.broken_image, color: Colors.redAccent, size: 60);
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),

                                // Like & Comment Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            likedReports.contains(index) ? Icons.thumb_up_alt : Icons.thumb_up_off_alt,
                                            color: Colors.greenAccent,
                                          ),
                                          onPressed: () => _incrementLike(index),
                                        ),
                                        Text(
                                          "${reports[index]["likes"]}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.comment, color: Colors.greenAccent),
                                      onPressed: () => _showCommentBottomSheet(context, index),
                                    ),
                                  ],
                                ),

                                // Comments Section (Scrollable)
                                if ((reports[index]["comments"] as List<String>).isNotEmpty)
                                  Container(
                                    height: 100, // Limit height for scrolling
                                    padding: EdgeInsets.only(top: 5),
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: reports[index]["comments"].map<Widget>((comment) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: 3),
                                          child: Text("- $comment", style: TextStyle(color: Colors.white70)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
