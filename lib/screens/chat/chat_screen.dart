import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/part_match.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late PartMatch match;
  late TextEditingController _controller;
  late List<Map<String, dynamic>> _messages;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as PartMatch?;
      if (args != null) {
        setState(() {
          match = args;
          _messages = List.from(MockDataService.getChatMessages(match.id));
        });
      } else {
        match = PartMatch(
          id: "0",
          name: "Unknown",
          distance: "",
          has: "",
          wants: "",
          avatar: "https://via.placeholder.com/50",
        );
        _messages = [];
      }
      _controller = TextEditingController();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        "text": _controller.text.trim(),
        "isUser": true,
        "time": _formatTime(DateTime.now()),
      });
      _controller.clear();
    });
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(match.avatar),
              radius: 16,
            ),
            const SizedBox(width: 10),
            Text(match.name),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppConstants.routeSuccess,
                    (route) => false,
              );
            },
            icon: const Icon(Icons.check_circle_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  text: message['text'],
                  time: message['time'],
                  isUser: message['isUser'],
                );
              },
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  child: const Icon(Icons.send, size: 18),
                  backgroundColor: AppConstants.secondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}