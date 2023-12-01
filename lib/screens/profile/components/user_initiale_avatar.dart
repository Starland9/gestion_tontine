import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';

class UserInitialeAvatar extends StatelessWidget {
  const UserInitialeAvatar({super.key, required this.user, this.radius});

  final User user;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      radius: radius,
      child: Text(
        user.initiales.toUpperCase(),
        style: TextStyle(color: Colors.white, fontSize: (radius ?? 16 * 0.8)),
      ),
    );
  }
}
