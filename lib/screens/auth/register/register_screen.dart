import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:hive/hive.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.user});

  final User? user;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _professionController = TextEditingController();
  DateTime? _birthDate;

  @override
  void initState() {
    _emailController.text = widget.user?.email ?? '';
    _passwordController.text = widget.user?.password ?? '';
    _firstNameController.text = widget.user?.firstName ?? '';
    _lastNameController.text = widget.user?.lastName ?? '';
    _professionController.text = widget.user?.profession ?? '';

    if (widget.user?.birthDate != null) {
      _birthDate = widget.user?.birthDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _professionController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _selectBirthDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _birthDate = date;
      });
    }
  }

  void _register() {
    // Implement your login logic here
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    // Example: Checking if email and password match
    if (email.isNotEmpty && password.isNotEmpty) {
      if (widget.user != null) {
        widget.user!.firstName = firstName;
        widget.user!.lastName = lastName;
        widget.user!.profession = _professionController.text.trim();
        widget.user!.birthDate = _birthDate ?? DateTime.now();
        widget.user!.save();
      } else {
        // Login successful
        // Save user session using Hive
        final user = User(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          isAdmin: firstName == "admin",
          profession: _professionController.text.trim(),
          birthDate: _birthDate ?? DateTime.now(),
        );
        final box = Hive.box<User>('users');
        box.add(user);

        // Navigate to the next screen
      }
      Navigator.of(context).pop();
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
        title: const Text('Creer un compte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                readOnly: widget.user != null,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _professionController,
                decoration: const InputDecoration(
                  labelText: 'Profession',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller:
                    TextEditingController(text: _birthDate?.toString() ?? ""),
                decoration: const InputDecoration(
                  labelText: 'Date de naissance',
                ),
                onTap: _selectBirthDate,
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
              ElevatedButton(
                onPressed: _register,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
