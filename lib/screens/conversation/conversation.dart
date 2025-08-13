import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final List<Map<String, String>> _conversationHistory = [];
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchConversationHistory();
  }

  Future<void> _fetchConversationHistory() async {
    // Simulate fetching data from a backend or database
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    setState(() {
      _conversationHistory.addAll([
        {'sender': 'Mitara', 'message': 'Hello! How can I assist you today?'},
        {'sender': 'Elderly', 'message': 'What is my medication schedule?'},
        {
          'sender': 'Mitara',
          'message': 'You have a pill scheduled for 8:00 AM.',
        },
        {'sender': 'Elderly', 'message': 'What is the weather today?'},
        {'sender': 'Mitara', 'message': 'It is sunny with a high of 25°C.'},
      ]);
      _isLoading = false;
    });
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _conversationHistory.add({'sender': 'Admin', 'message': message});
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversation History'),
        // backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _fetchConversationHistory();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _conversationHistory.length,
                    itemBuilder: (context, index) {
                      final message = _conversationHistory[index];
                      final isElderly = message['sender'] == 'Elderly';
                      final isAdmin = message['sender'] == 'Admin';
                      return Align(
                        alignment: isElderly
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isElderly
                                ? Colors.grey[300]
                                : isAdmin
                                ? Colors.blue[100]
                                : Colors.teal[100],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            '${message['sender']}: ${message['message']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _sendMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
