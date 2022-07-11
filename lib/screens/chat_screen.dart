import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();

  bool hasTypedMessage = false;

  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          title: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
                child: const Text("Ja"),
              ),
              const SizedBox(height: 3),
              const Text(
                "Jane Doe",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ],
          ),
        ),
        body: Column(children: [
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                return _messages[index];
              },
              reverse: true,
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(color: Colors.transparent, height: 60, child: _inputChat())
        ]));
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration.collapsed(
                  hintText: "Mensaje... ",
                ),
                onSubmitted: (_) {},
                onChanged: (value) {
                  hasTypedMessage = value.isNotEmpty;
                  setState(() {});
                },
                focusNode: _messageFocusNode,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: const Text("Enviar"),
                      onPressed: () {},
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: hasTypedMessage ? Colors.blue : Colors.grey,
                        child: IconButton(
                            icon: const Icon(
                              Icons.send_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: !hasTypedMessage ? null : _handleSubmit),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_messageController.text.isEmpty) {
      return;
    }

    final message = ChatMessage(
      uid: "1",
      text: _messageController.text,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      ),
    );
    _messages.insert(0, message);
    message.animationController.forward();

    _messageController.clear();
    _messageFocusNode.requestFocus();
    hasTypedMessage = false;
    setState(() {});
  }

  @override
  void dispose() {
    //TODO Off del socket
    for (final message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
