import 'package:flutter/cupertino.dart';
import 'package:realtime_chat/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/users': (_) => const UsersScreen(),
  '/chat': (_) => const ChatScreen(),
  '/login': (_) => const LoginScreen(),
  '/register': (_) => const RegisterScreen(),
  '/loading': (_) => const LoadingScreen(),
};
