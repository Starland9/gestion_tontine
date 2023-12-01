import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:gestion_tontine/shared/utils/navigate.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../home/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _login() {
    // Implement your login logic here
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email == "admin@gmail.com" && password == "admin") {
      Nav.toAndRemove(
        context,
        HomePage(
          user: User(
            firstName: "Admin",
            lastName: "Super",
            email: email,
            password: password,
            isAdmin: true,
            profession: "Administrateur",
            birthDate: DateTime.now(),
          ),
        ),
      );
      return;
    }

    if (email == "user@gmail.com" && password == "user") {
      Nav.toAndRemove(
        context,
        HomePage(
          user: User(
            firstName: "User",
            lastName: "Simple",
            email: email,
            password: password,
            isAdmin: false,
            profession: "Membre",
            birthDate: DateTime.now(),
          ),
        ),
      );
      return;
    }

    final userBox = Hive.box<User>("users");

    try {
      final user = userBox.values.firstWhere(
        (element) => element.email == email && element.password == password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  user: user,
                )),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Email ou mot de passe incorrect.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion de Tontine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Connexion",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
