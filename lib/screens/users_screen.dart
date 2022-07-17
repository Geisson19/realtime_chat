import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:realtime_chat/models/user.dart';
import 'package:realtime_chat/service/services.dart';
import 'package:realtime_chat/service/users_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final usersService = UsersService();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final List<User> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final currentUser = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentUser.name,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            // Desconectar el socket server
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, '/login');
            AuthService.deleteToken();
          },
          icon: const Icon(Icons.exit_to_app, color: Colors.black),
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 16),
              child: socketService.serverStatus == ServerStatus.online
                  ? const Icon(Icons.check_circle, color: Colors.lightBlue)
                  : const Icon(Icons.error, color: Colors.red))
        ],
      ),
      body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _loadUsers,
          child: _ListViewUser(users: users)),
    );
  }

  void _loadUsers() async {
    final newUsers = await usersService.getUsers();
    setState(() {
      users.clear();
      users.addAll(newUsers);
    });
    setState(() {});
    _refreshController.refreshCompleted();
  }
}

class _ListViewUser extends StatelessWidget {
  const _ListViewUser({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (_, index) {
        return const Divider();
      },
      itemBuilder: (_, index) {
        return _SingleUser(user: users[index]);
      },
    );
  }
}

class _SingleUser extends StatelessWidget {
  const _SingleUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(child: Text(user.name.substring(0, 2))),
      trailing: user.isOnline
          ? const Icon(
              Icons.circle_rounded,
              color: Colors.green,
              size: 15,
            )
          : const Icon(
              Icons.circle_rounded,
              color: Colors.red,
              size: 15,
            ),
      onTap: () {
        final ChatService chatService =
            Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.pushNamed(context, '/chat');
      },
    );
  }
}
