import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:gestion_tontine/screens/cotisation/cotisation_screen.dart';
import 'package:gestion_tontine/screens/notification/notification_page.dart';
import 'package:gestion_tontine/screens/operation/transaction_page.dart';
import 'package:gestion_tontine/screens/reunion/reunion_list_page.dart';
import 'package:gestion_tontine/screens/user/user_list_page.dart';
import 'package:gestion_tontine/shared/utils/navigate.dart';

import '../profile/profile_page.dart';

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
              icon: const Icon(Icons.person),
              onPressed: () => Nav.to(
                    context,
                    ProfilePage(user: user),
                  )),
          IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () => Nav.to(
                    context,
                    Badge(
                      label: const Text("20"),
                      child: NotificationPage(
                        user: user,
                      ),
                    ),
                  )),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          // OptionButton(
          //   title: 'Compte',
          //   icon: Icons.account_balance,
          //   color: Colors.blue,
          //   onPressed: () {
          //     Nav.to(context, const AccountPage());
          //   },
          // ),
          OptionButton(
            title: 'Effectuer une cotisation',
            icon: Icons.monetization_on,
            color: Colors.green,
            onPressed: () {
              Nav.to(
                  context,
                  CotisationPage(
                    user: user,
                  ));
            },
          ),
          OptionButton(
            title: 'Effectuer une transaction',
            icon: Icons.attach_money,
            color: Colors.purple,
            onPressed: () {
              Nav.to(
                  context,
                  TransactionPage(
                    user: user,
                  ));
            },
          ),
          if (user.isAdmin)
            OptionButton(
              title: 'Gestion des utilisateurs',
              icon: Icons.person,
              color: Colors.red,
              onPressed: () {
                Nav.to(context, const UserListPage());
              },
            ),
          // if (user.isAdmin)
          OptionButton(
            title: user.isAdmin ? 'Gestion des reunions' : "Mes reunions",
            icon: Icons.group,
            color: Colors.teal,
            onPressed: () {
              Nav.to(
                  context,
                  MeetingListPage(
                    user: user,
                  ));
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
                textAlign: TextAlign.center,
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
