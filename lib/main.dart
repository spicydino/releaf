import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:releaf/Home_page.dart';
import 'package:releaf/Waste%20Management/Community/CommunityPage.dart';
import 'package:releaf/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    
    debugShowCheckedModeBanner: false,
    home: BinItLoginPage(),
  ));
}


