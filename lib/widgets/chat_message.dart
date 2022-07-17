import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/service/auth_service.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {Key? key,
      required this.uid,
      required this.text,
      required this.animationController})
      : super(key: key);

  final String uid;
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
        child: Container(
          child: uid == authService.user.uid
              ? _messageFromMe()
              : _messageFromOther(),
        ),
      ),
    );
  }

  Widget _messageFromMe() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8, left: 50),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 46, 137, 236),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _messageFromOther() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 8, bottom: 8, right: 50),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: const BoxDecoration(
          color: Color(0xffe4e5e8),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
