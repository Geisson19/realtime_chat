import 'package:flutter/material.dart';
import 'package:realtime_chat/global/enviroment.dart';
import 'package:realtime_chat/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/service/auth_service.dart';

class ChatService with ChangeNotifier {
  late User userTo;

  Future<List<Message>> getChat(String userId) async {
    final uri = Uri.http(Enviroment.apiUrl, '/api/messages/$userId');

    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    final messagesResponse = messagesResponseFromJson(response.body);

    return messagesResponse.messages;
  }
}
