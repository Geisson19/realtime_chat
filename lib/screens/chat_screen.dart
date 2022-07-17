import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/models/models.dart';
import 'package:realtime_chat/service/services.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  bool hasTypedMessage = false;

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.client.on('send-message', _listenMessage);

    _loadHistorial(chatService.userTo.uid);
  }

  void _loadHistorial(String userId) async {
    final List<Message> messages = await chatService.getChat(userId);

    final historial = messages
        .map((Message message) => ChatMessage(
              text: message.message,
              uid: message.from,
              animationController: AnimationController(
                vsync: this,
                duration: const Duration(milliseconds: 300),
              )..forward(),
            ))
        .toList();

    setState(() {
      _messages.insertAll(0, historial);
    });
  }

  void _listenMessage(payload) {
    ChatMessage message = ChatMessage(
      uid: payload["from"],
      text: payload["message"],
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final User userTo = chatService.userTo;

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
                child: Text(userTo.name.substring(0, 2)),
              ),
              const SizedBox(height: 3),
              Text(
                userTo.name,
                style: const TextStyle(color: Colors.black, fontSize: 12),
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
      uid: authService.user.uid,
      text: _messageController.text,
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      ),
    );
    _messages.insert(0, message);
    message.animationController.forward();

    hasTypedMessage = false;
    socketService.client.emit('send-message', {
      'from': authService.user.uid,
      'to': chatService.userTo.uid,
      'message': _messageController.text
    });
    _messageFocusNode.requestFocus();
    _messageController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    for (final message in _messages) {
      message.animationController.dispose();
    }
    socketService.client.off('send-message');

    super.dispose();
  }
}
