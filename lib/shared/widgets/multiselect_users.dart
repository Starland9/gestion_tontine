import 'package:flutter/material.dart';

import '../../models/user/user.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<User> userList;
  final List<User> selectedUsers;
  final ValueChanged<List<User>> onChanged;

  const MultiSelectDropdown({
    super.key,
    required this.userList,
    required this.selectedUsers,
    required this.onChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<User> _selectedUsers = [];

  @override
  void initState() {
    _selectedUsers = widget.selectedUsers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<User>(
      value: null,
      hint: const Text('selectionner des utilisateurs'),
      items: widget.userList.map((user) {
        return DropdownMenuItem<User>(
          value: user,
          child: Row(
            children: <Widget>[
              Checkbox(
                value: _selectedUsers.contains(user),
                onChanged: (bool? value) {
                  setState(() {
                    if (value != null && value) {
                      _selectedUsers.add(user);
                    } else {
                      _selectedUsers.remove(user);
                    }
                    widget.onChanged(_selectedUsers);
                  });
                },
              ),
              const SizedBox(width: 8.0),
              Text(user.fullName),
            ],
          ),
        );
      }).toList(),
      onChanged: (User? value) {},
      isExpanded: true,
      isDense: true,
      elevation: 0,
    );
  }
}
