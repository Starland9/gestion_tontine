import 'package:flutter/material.dart';
import 'package:gestion_tontine/screens/auth/login/login_screen.dart';
import 'package:gestion_tontine/shared/utils/navigate.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Gestion de Tontine",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset("assets/images/icon.png"),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _gotoLoging,
                child: const Text('Connexion'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _gotoLoging() {
    Nav.toAndRemove(
      context,
      const LoginPage(),
    );
  }
}
