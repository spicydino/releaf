import 'package:flutter/material.dart';
import 'package:releaf/chat_message.dart';
import '../services/carbon_tips_service.dart';
import '../services/carbon_calculation_service.dart';

class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final CarbonTipsService _tipsService = CarbonTipsService();
  final CarbonCalculationService _calculationService = CarbonCalculationService();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    _addBotMessage("Hello! I'm your carbon assistant. I can help you track and reduce your carbon footprint. Ask me anything about your emissions or for tips on how to be more sustainable.");
  }

  void _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _isComposing = false;
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });

    // Get carbon data for contextual responses
    final carbonData = await _calculationService.getCarbonData();
    
    // Generate bot response
    String response = _tipsService.generateResponse(text, carbonData);
    
    // Add slight delay to make the conversation feel more natural
    await Future.delayed(Duration(milliseconds: 500));
    
    _addBotMessage(response);
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Chat header
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.green.shade800,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.chat, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Carbon Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true, // Display newest messages at the bottom
              itemCount: _messages.length,
              itemBuilder: (_, int index) {
                final message = _messages[_messages.length - index - 1];
                return _buildMessage(message);
              },
            ),
          ),
          
          // Divider
          Divider(height: 1.0),
          
          // Text input
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
                      child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    final isUser = message.isUser;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: 
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) 
            CircleAvatar(
              backgroundColor: Colors.green.shade700,
              child: Icon(Icons.eco, color: Colors.white, size: 16),
            ),
          SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isUser ? Colors.green.shade700 : Colors.grey.shade800,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          if (isUser) 
            CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: _isComposing ? _handleSubmitted : null,
              decoration: InputDecoration(
                hintText: "Ask me about your carbon footprint...",
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing
                ? () => _handleSubmitted(_textController.text)
                : null,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}