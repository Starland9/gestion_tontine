import 'package:flutter/material.dart';
import 'package:gestion_tontine/screens/auth/register/register_screen.dart';
import 'package:gestion_tontine/screens/profile/components/user_initiale_avatar.dart';
import 'package:gestion_tontine/shared/utils/navigate.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/user/user.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key, this.forManage = true});

  final bool forManage;

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
      filteredUserList = Hive.box<User>('users')
          .values
          .toList()
          .where((user) =>
              user.lastName.toLowerCase().contains(query.toLowerCase()) ||
              user.firstName.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // void _toggleUserSelection(User user) {
  //   setState(() {
  //     if (selectedUsers.contains(user)) {
  //       selectedUsers.remove(user);
  //     } else {
  //       selectedUsers.add(user);
  //     }
  //   });
  // }

  void _closePage() {
    Navigator.pop(context, selectedUsers);
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<User>('users');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des membres'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: _searchUser,
              decoration: const InputDecoration(
                labelText: 'Rechercher un membre',
              ),
            ),
          ),
          ValueListenableBuilder<Box<User>>(
              valueListenable: box.listenable(),
              builder: (context, box, _) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredUserList.length,
                    itemBuilder: (context, index) {
                      final user = filteredUserList[index];
                      // final isSelected = selectedUsers.contains(user);

                      return ListTile(
                        title: Text(user.fullName),
                        subtitle: Text(user.email),
                        leading: UserInitialeAvatar(
                          user: user,
                        ),
                        // trailing: Text(user.email),
                        // leading: isSelected
                        //     ? const Icon(Icons.check_circle, color: Colors.blue)
                        //     : const Icon(Icons.circle_outlined),
                        // onTap: () => _toggleUserSelection(user),
                        onTap: () => _updateUser(user),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            box.deleteAt(index);
                          },
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: widget.forManage
          ? FloatingActionButton(
              onPressed: _createUser,
              child: const Icon(Icons.person_add),
            )
          : FloatingActionButton(
              onPressed: _closePage,
              child: const Icon(Icons.done),
            ),
    );
  }

  void _createUser() {
    Nav.to(context, const RegisterPage());
  }

  void _updateUser(User user) {
    Nav.to(
        context,
        RegisterPage(
          user: user,
        ));
  }
}
