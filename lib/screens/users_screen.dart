import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:realtime_chat/models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final List<User> users = [
    User(
      uid: '1',
      name: 'John Doe',
      email: 'jhon@email.com',
      isOnline: true,
    ),
    User(
      uid: '2',
      name: 'Jane Doe',
      email: 'jane@email.com',
      isOnline: false,
    ),
    User(
      uid: '3',
      name: 'Jack Doe',
      email: 'jack@email.com',
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'user.name',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app, color: Colors.black),
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 16),
              child: const Icon(Icons.check_circle, color: Colors.lightBlue))
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
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
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
      onTap: () {},
    );
  }
}
