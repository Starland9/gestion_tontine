import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/notification/notification.dart' as app;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CreateNotificationPage extends StatefulWidget {
  const CreateNotificationPage({super.key});

  @override
  State<CreateNotificationPage> createState() => _CreateNotificationPageState();
}

class _CreateNotificationPageState extends State<CreateNotificationPage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _createNotification() {
    final createdAt = DateTime.now();
    final title = _titleController.text;
    final body = _bodyController.text;

    // Validate input

    // Create Account object
    if (_titleController.text.isNotEmpty) {
      final notification = app.Notification(
        title: title,
        body: body,
        createdAt: createdAt,
      );

      // Save account to Hive box
      final box = Hive.box<app.Notification>('notifications');
      box.add(notification);
    }

    // Show success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification cree'),
        content: const Text('Avec success'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Creer une notification'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16.0),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titre',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Details',
              ),
              minLines: 3,
              maxLines: null,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _createNotification,
              child: const Text('Creer la notification'),
            ),
          ],
        ),
      ),
    );
  }
}
