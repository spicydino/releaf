import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:releaf/chat_message.dart';
import 'package:releaf/services/gemini_service.dart';

class EcoChatScreen extends StatefulWidget {
  const EcoChatScreen({Key? key}) : super(key: key);

  @override
  _EcoChatScreenState createState() => _EcoChatScreenState();
}

class _EcoChatScreenState extends State<EcoChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final GeminiService _geminiService = GeminiService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPreviousConversation();
  }

  /// **Loads previous chat history**
  Future<void> _loadPreviousConversation() async {
    final messages = await _geminiService.loadConversation();
    setState(() {
      _messages
        ..clear()
        ..addAll(messages);
    });

    if (_messages.isEmpty) {
      _messages.add(ChatMessage(
        text: "Hello! I'm your BinIt EcoAssistant. How can I help you reduce your carbon footprint today?",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    }
  }

  /// **Handles user message submission**
  void _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    _textController.clear();

    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    try {
      final response = await _geminiService.sendMessage(
        text,
        _messages,
      );

      final botMessage = ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(botMessage);
        _isLoading = false;
      });

      // Save conversation history
      await _geminiService.saveConversation(_messages);
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: "Sorry, I couldn't process your message. Please try again.",
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoAssistant', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade800,
        actions: [
          IconButton(
            icon: const Icon(Icons.eco, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About EcoAssistant'),
                  content: const Text(
                    'Your AI assistant that helps you understand and reduce your carbon footprint. '
                    'Ask questions about environmental actions, carbon reduction tips, or get explanations about your BinIt data.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _buildMessageBubble(_messages[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 6),
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          _buildTextComposer(),
        ],
      ),
    );
  }

  /// **Message bubble UI**
  Widget _buildMessageBubble(ChatMessage message) {
    final formattedTime = DateFormat('hh:mm a').format(message.timestamp);
    
    return Row(
      mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isUser)
          const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.eco, color: Colors.white, size: 16),
          ),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.green.shade700 : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    formattedTime,
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        if (message.isUser)
          const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.person, color: Colors.white, size: 16),
          ),
      ],
    );
  }

  /// **Message input field**
  Widget _buildTextComposer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Ask about reducing your carbon footprint...',
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.green),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}
