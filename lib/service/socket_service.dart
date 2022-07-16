import 'package:flutter/cupertino.dart';
import 'package:realtime_chat/global/enviroment.dart';
import 'package:realtime_chat/service/auth_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus {
  online,
  offline,
  connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;

  late io.Socket _client;

  ServerStatus get serverStatus => _serverStatus;

  io.Socket get client => _client;

  SocketService() {
    connect();
  }

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    _client = io.io('https://${Enviroment.apiUrl}/', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token},
    });

    // Client hears server connection status from server
    _client.on('connect', (_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });
    _client.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _client.on('message', (data) {
      print(data);
    });
  }

  void disconnect() {
    _client.disconnect();
  }
}
