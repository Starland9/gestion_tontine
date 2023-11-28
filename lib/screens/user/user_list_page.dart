import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/user/user.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> selectedUsers = [];
  List<User> userList = [];
  List<User> filteredUserList = [];

  @override
  void initState() {
    super.initState();
    userList = Hive.box<User>('users').values.toList();
    filteredUserList = userList;
  }

  void _searchUser(String query) {
    setState(() {
      filteredUserList = userList
          .where((user) =>
              user.lastName.toLowerCase().contains(query.toLowerCase()) ||
              user.firstName.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleUserSelection(User user) {
    setState(() {
      if (selectedUsers.contains(user)) {
        selectedUsers.remove(user);
      } else {
        selectedUsers.add(user);
      }
    });
  }

  void _closePage() {
    Navigator.pop(context, selectedUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchUser,
              decoration: const InputDecoration(
                labelText: 'Search Users',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUserList.length,
              itemBuilder: (context, index) {
                final user = filteredUserList[index];
                final isSelected = selectedUsers.contains(user);

                return ListTile(
                  title: Text(user.firstName),
                  subtitle: Text(user.email),
                  // trailing: Text(user.email),
                  leading: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : const Icon(Icons.circle_outlined),
                  onTap: () => _toggleUserSelection(user),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _closePage,
        child: const Icon(Icons.done),
      ),
    );
  }
}
