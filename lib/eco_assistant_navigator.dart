import 'package:flutter/material.dart';
import 'package:releaf/screens/eco_chat_screens.dart';

class EcoAssistantNavigator {
  static void navigateToChat(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const EcoChatScreen())
    );
  }
}