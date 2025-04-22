import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatboatScreen extends StatefulWidget {
  const ChatboatScreen({super.key});

  @override
  State<ChatboatScreen> createState() => _ChatboatScreenState();
}

class _ChatboatScreenState extends State<ChatboatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Gemini.init(
      apiKey: 'AIzaSyDxi6ajVL3B6tRIUdfGkk_yojP9fu1NR9c',
    );
  }

  Future<void> sendMessageToGemini(String message) async {
    setState(() => _isLoading = true);

    try {
      final response = await Gemini.instance.text(message);

      setState(() {
        _messages.add({
          'sender': 'ai',
          'message': response?.output ?? 'No response from Gemini',
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'ai',
          'message': 'Error: ${e.toString()}',
        });
      });
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat with AI",
          style: TextStyle(
            // color: Colors.white,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black87
                : Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[_messages.length - 1 - index];
                  final isUserMessage = message['sender'] == 'user';
                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUserMessage
                            ? Colors.blueAccent
                            : Theme.of(context).brightness == Brightness.dark
                                ? Colors.black87
                                : Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(15),
                          topRight: const Radius.circular(15),
                          bottomLeft: Radius.circular(isUserMessage ? 15 : 0),
                          bottomRight: Radius.circular(isUserMessage ? 0 : 15),
                        ),
                      ),
                      child: Text(
                        message['message']!,
                        style: TextStyle(
                          color: isUserMessage
                              ? Colors.white
                              : Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        filled: true,
                        // fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: () {
                      final message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        setState(() {
                          _messages.add({'sender': 'user', 'message': message});
                          _messageController.clear();
                        });
                        sendMessageToGemini(message);
                      }
                    },
                    backgroundColor: Colors.blueAccent,
                    child: const Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
