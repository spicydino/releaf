import 'dart:io';
import 'package:flutter/material.dart';
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

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        images.addAll(pickedImages);
      });
    }
  }

  void _submitReport(BuildContext context) {
    if (reportController.text.isEmpty && images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please add a report or images.")),
      );
      return;
    }

    // Pass the report to the community page (You can modify this logic)
    Navigator.pop(context, {
      "report": reportController.text,
      "images": images,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Waste Management Guidelines")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bin Location: ${widget.binLocation}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Waste Management Guidelines:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "- Segregate waste properly before disposal.\n"
              "- Avoid throwing hazardous materials in normal bins.\n"
              "- Ensure recyclable waste is placed in designated bins.\n"
              "- Report overflowing bins or improper disposal.",
            ),
            SizedBox(height: 20),
            TextField(
              controller: reportController,
              decoration: InputDecoration(labelText: "Add a report"),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            Wrap(
              children: images.map((image) {
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Image.file(File(image.path), width: 60, height: 60, fit: BoxFit.cover),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text("Add Images"),
                ),
                ElevatedButton(
                  onPressed: () => _submitReport(context),
                  child: Text("Submit Report"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
