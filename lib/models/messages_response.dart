// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

MessagesResponse messagesResponseFromJson(String str) =>
    MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) =>
    json.encode(data.toJson());

class MessagesResponse {
  MessagesResponse({
    required this.ok,
    required this.messages,
  });

  bool ok;
  List<Message> messages;

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      MessagesResponse(
        ok: json["ok"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    required this.to,
    required this.from,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  String to;
  String from;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        to: json["to"],
        from: json["from"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "from": from,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
