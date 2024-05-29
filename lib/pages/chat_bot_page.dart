// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: _messageController.text,
          isSentByMe: true,
        ));
        _messageController.clear();

        // Обработка команд
        String response = _processCommand(_messageController.text);

        _messages.add(ChatMessage(
          text: response,
          isSentByMe: false,
        ));
      });
    }
  }

  String _processCommand(String message) {
    if (message.toLowerCase() == 'hello') {
      return 'Hello! Good to see you!';
    } else if (message.toLowerCase() == 'whats up?') {
      return 'Very good, thanks! And you?';
    } else if (RegExp(r'weather').hasMatch(message.toLowerCase())) {
      return 'Sorry, I do not know the weather. 😥';
    } else if (RegExp(r'fitness').hasMatch(message.toLowerCase())) {
      return 'Fitness is a journey, not a destination, so focus on making small, sustainable changes to your lifestyle. Regular exercise is essential for both physical and mental well-being.';
    } else if (RegExp(r'best trainers').hasMatch(message.toLowerCase())) {
      return 'Unfortunately, I cannot provide a list of the "best" coaches because: Subjectivity: The “best” coach depends on individual needs, goals and preferences.';
    } else if (RegExp(r'what can you do').hasMatch(message.toLowerCase())) {
      return 'Can I tell you about the GetmMoreFit application, tell you?';
    } else if (RegExp(r'yes').hasMatch(message.toLowerCase())) {
      return 'GetMoreFit is a revolutionary fitness app designed to help you achieve your fitness goals and live a healthier lifestyle. It offers a personalized experience, tailored to your unique needs and aspirations.GetMoreFit is your ultimate fitness companion, empowering you to take control of your health and achieve your full potential.';
    } else {
      return 'I dont understand. 😕';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Chat-bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment:
          message.isSentByMe ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: message.isSentByMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isSentByMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isSentByMe;

  ChatMessage({required this.text, required this.isSentByMe});
}
