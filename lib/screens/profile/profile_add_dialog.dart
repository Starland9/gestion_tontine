import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/profile/profile.dart';
import 'package:hive/hive.dart';

class ProfileAddDialog extends StatefulWidget {
  const ProfileAddDialog({super.key});

  @override
  State<ProfileAddDialog> createState() => _ProfileAddDialogState();
}

class _ProfileAddDialogState extends State<ProfileAddDialog> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addAccount() {
    if (_nameController.text.isEmpty) {
      return;
    }

    // Create Account object
    final profile = Profile(name: _nameController.text);

    // Save account to Hive box
    final box = Hive.box<Profile>('profiles');
    box.add(profile);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom',
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
}
