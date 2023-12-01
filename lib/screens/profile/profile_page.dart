import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:gestion_tontine/screens/profile/components/user_initiale_avatar.dart';

import '../../shared/utils/navigate.dart';
import '../auth/login/login_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                UserInitialeAvatar(user: user, radius: 50,),
                const SizedBox(height: 16.0),
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(user.email),
              ],
            ),
            Column(
              children: [
                Text(user.profession, style: const TextStyle(fontSize: 16)),
                Text(
                    "Date de naissance : ${user.birthDate.day}/${user.birthDate.month}/${user.birthDate.year}"),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Nav.toAndRemove(context, const LoginPage());
                  },
                  child: const Text('Deconnexion'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
