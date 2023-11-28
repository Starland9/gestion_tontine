import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/reunion/reunion.dart';
import 'package:gestion_tontine/screens/user/user_list_page.dart';
import 'package:hive/hive.dart';

import '../../models/user/user.dart';

class AddReunionDialog extends StatefulWidget {
  const AddReunionDialog({super.key});

  @override
  State<AddReunionDialog> createState() => _AddReunionDialogState();
}

class _AddReunionDialogState extends State<AddReunionDialog> {
  final _causeController = TextEditingController();
  final List<User> _participants = [];

  @override
  void dispose() {
    _causeController.dispose();
    super.dispose();
  }

  void _addAccount() {
    if (_participants.isEmpty) {
      return;
    }

    // Create Account object
    final Reunion reunion = Reunion(
      cause: _causeController.text,
      date: DateTime.now(),
      participants: _participants,
    );

    // Save account to Hive box
    final box = Hive.box<Reunion>('reunions');
    box.add(reunion);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter une reunion'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _causeController,
              decoration: const InputDecoration(
                labelText: 'Type',
              ),
            ),
            const SizedBox(height: 16.0),
            if (_participants.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: _participants.length,
                itemBuilder: (context, index) {
                  final user = _participants[index];
                  return Text(user.firstName);
                },
              ),
            ElevatedButton(
              onPressed: _selectParticipants,
              child: const Text(
                "Selectionner les participants",
              ),
            ),
            const SizedBox(height: 16.0),
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

  void _selectParticipants() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const UserListPage()))
        .then((value) => {
              if (value is List<User>)
                {
                  setState(() {
                    _participants.addAll(value);
                  })
                }
            });
  }
}
