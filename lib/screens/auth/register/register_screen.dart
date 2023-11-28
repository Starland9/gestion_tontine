import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:hive/hive.dart';

import '../../home/home_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _register() {
    // Implement your login logic here
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    // Example: Checking if email and password match
    if (email.isNotEmpty && password.isNotEmpty) {
      // Login successful
      // Save user session using Hive
      final user = User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        isAdmin: firstName == "admin",
      );
      final box = Hive.box<User>('users');
      box.add(user);

      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  user: user,
                )),
      );
    } else {
      // Login failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Remplissez bien les informations'),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Inscription",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Prenom',
                ),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
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
                      _passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('Creer mon compte'),
                  ),
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('j \'ai deja un compte'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
