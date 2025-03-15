import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:releaf/models/gemini_config.dart';
import 'package:releaf/chat_message.dart';

class GeminiService {
  final String _apiKey = GeminiConfig.apiKey;
  final String _baseUrl = GeminiConfig.baseUrl;
  final String _modelName = GeminiConfig.modelName;

  /// **Save conversation locally**
  Future<void> saveConversation(List<ChatMessage> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> messageStrings =
        messages.map((msg) => jsonEncode(msg.toJson())).toList();
    await prefs.setStringList('conversation', messageStrings);
  }

  /// **Load conversation from local storage**
  Future<List<ChatMessage>> loadConversation() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? messageStrings = prefs.getStringList('conversation');
    if (messageStrings == null) return [];

    return messageStrings
        .map((msg) => ChatMessage.fromJson(jsonDecode(msg)))
        .toList();
  }

  /// **Send message to Gemini API**
  Future<String> sendMessage(String text, List<ChatMessage> messages) async {
    if (_apiKey.isEmpty) {
      return _getFallbackResponse(text);
    }

    try {
      final url = '$_baseUrl/models/$_modelName:generateContent?key=$_apiKey';

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text': text,
                }
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return _getFallbackResponse(text);
      }
    } catch (e) {
      print('Exception: $e');
      return _getFallbackResponse(text);
    }
  }

  /// **Generate a fallback response when API is not available**
  String _getFallbackResponse(String prompt) {
    final lowerPrompt = prompt.toLowerCase();

    if (lowerPrompt.contains('hello') || lowerPrompt.contains('hi')) {
      return "Hello! I'm your carbon assistant. How can I help you today?";
    }

    if (lowerPrompt.contains('carbon') && lowerPrompt.contains('footprint')) {
      return "I can help you track and understand your carbon footprint. Try adding some activities first.";
    }

    if (lowerPrompt.contains('tip') || lowerPrompt.contains('advice')) {
      return "To reduce your carbon footprint, consider using public transport, switching to energy-efficient appliances, or eating a plant-based diet.";
    }

    return "I'm here to help with carbon footprint tracking and reduction tips.";
  }
}
