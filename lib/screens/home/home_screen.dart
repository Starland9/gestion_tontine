import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:gestion_tontine/screens/account/account_screen.dart';
import 'package:gestion_tontine/screens/auth/login/login_screen.dart';
import 'package:gestion_tontine/screens/cotisation/cotisation_screen.dart';
import 'package:gestion_tontine/screens/notification/notification_page.dart';
import 'package:gestion_tontine/screens/operation/operations_page.dart';
import 'package:gestion_tontine/screens/profile/profile_list_page.dart';
import 'package:gestion_tontine/screens/reunion/reunion_list_page.dart';
import 'package:gestion_tontine/shared/utils/navigate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue ${user.firstName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Nav.toAndRemove(context, const LoginPage());
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          OptionButton(
            title: 'Compte',
            icon: Icons.account_balance,
            color: Colors.blue,
            onPressed: () {
              Nav.to(context, const AccountPage());
            },
          ),
          OptionButton(
            title: 'Cotisation',
            icon: Icons.monetization_on,
            color: Colors.green,
            onPressed: () {
              Nav.to(context, const CotisationPage());
            },
          ),
          OptionButton(
            title: 'Notification',
            icon: Icons.notifications,
            color: Colors.orange,
            onPressed: () {
              Nav.to(context, const NotificationPage());
            },
          ),
          OptionButton(
            title: 'Opération',
            icon: Icons.attach_money,
            color: Colors.purple,
            onPressed: () {
              Nav.to(context, const OperationsPage());
            },
          ),
          OptionButton(
            title: 'Profil',
            icon: Icons.person,
            color: Colors.red,
            onPressed: () {
              Nav.to(context, const ProfilesPage());
            },
          ),
          OptionButton(
            title: 'Réunion',
            icon: Icons.group,
            color: Colors.teal,
            onPressed: () {
              Nav.to(context, const MeetingListPage());
            },
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _showCreateUserDialog,
      //   label: const Text("Creer un utilisateur"),
      // ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const OptionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48.0,
                color: Colors.white,
              ),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
