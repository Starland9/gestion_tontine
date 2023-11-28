import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/account/account.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Account> selectedMeetings = [];
  List<Account> meetingList = [];
  List<Account> filteredMeetingList = [];

  @override
  void initState() {
    meetingList = Hive.box<Account>('accounts').values.toList();
    filteredMeetingList = meetingList;
    super.initState();
  }

  void _searchMeeting(String query) {
    setState(() {
      filteredMeetingList = meetingList
          .where((meeting) =>
              meeting.type.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleMeetingSelection(Account meeting) {
    setState(() {
      if (selectedMeetings.contains(meeting)) {
        selectedMeetings.remove(meeting);
      } else {
        selectedMeetings.add(meeting);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Account>('accounts');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des comptes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchMeeting,
              decoration: const InputDecoration(
                labelText: 'Rechercher un Compte',
              ),
            ),
          ),
          ValueListenableBuilder<Box<Account>>(
            valueListenable: box.listenable(),
            builder: (context, box, _) {
              return Expanded(
                child: ListView.builder(
                  itemCount: filteredMeetingList.length,
                  itemBuilder: (context, index) {
                    final account = filteredMeetingList[index];
                    // final isSelected = selectedMeetings.contains(account);

                    return ListTile(
                      leading: const Icon(
                        Icons.attach_money,
                        color: Colors.blue,
                      ),
                      title: Text('Type: ${account.type}'),
                      subtitle: Text(
                          "Montant: ${account.amount.toStringAsFixed(2)} FCFA"),
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
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddAccountDialog(),
          );
        },
      ),
    );
  }
}

class AddAccountDialog extends StatefulWidget {
  const AddAccountDialog({super.key});

  @override
  State<AddAccountDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  final _typeController = TextEditingController();
  final _amountController = TextEditingController();
  User? _user;

  @override
  void dispose() {
    _typeController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addAccount() {
    final type = _typeController.text;
    final amount = double.parse(_amountController.text);

    if (_user == null) {
      return;
    }

    // Create Account object
    final account = Account(
      createdAt: DateTime.now(),
      amount: amount,
      type: type,
      user: _user!,
    );

    // Save account to Hive box
    final box = Hive.box<Account>('accounts');
    box.add(account);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un compte'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(
                labelText: 'Type',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Montant',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<User>(
              value: _user,
              onChanged: (value) {
                setState(() {
                  _user = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Utilisateur',
              ),
              items: Hive.box<User>('users').values.map((user) {
                return DropdownMenuItem<User>(
                  value: user,
                  child: Text(user.firstName),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _addAccount,
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}
