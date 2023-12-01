import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/notification/notification.dart' as app;
import 'package:gestion_tontine/models/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'create_notification_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<app.Notification>('notifications');

    return Scaffold(
      appBar: AppBar(
        title: const Text('notifications'),
      ),
      body: ValueListenableBuilder<Box<app.Notification>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          final notifications = box.values.toList();

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                leading: const Icon(
                  Icons.notifications,
                  color: Colors.blue,
                ),
                title: Text(notification.title),
                subtitle: Text(notification.body),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    box.deleteAt(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: user.isAdmin
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const CreateNotificationPage(),
                );
              },
            )
          : null,
    );
  }
}
