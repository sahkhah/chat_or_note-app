// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:firebase_implementation/data/source/chat/chat_firebase_impl.dart';
import 'package:firebase_implementation/presentation/chat/display_message_screen.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  const ChatScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        actions: [TextButton(onPressed: () {}, child: Text('Lgout'))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: DisplayMessageScreen(name: widget.name),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) {
                          messageController.text = value;
                        },
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                          filled: true,
                          enabled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        final messageInfo = {
                          'message': messageController.text.trim(),
                          'time': DateTime.now(),
                          'name': widget.name,
                        };
                        if (messageController.text.isNotEmpty) {
                          ChatFirebaseImpl().sendMessage(messageInfo);
                        }

                        messageController.clear();
                      },
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
