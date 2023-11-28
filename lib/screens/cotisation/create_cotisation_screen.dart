import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/cotisation/cotisation.dart';
import '../user/user_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CotisationAdapter()); // Register the adapter

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CreateCotisationPage(),
    );
  }
}

class CreateCotisationPage extends StatefulWidget {
  const CreateCotisationPage({super.key});

  @override
  State<CreateCotisationPage> createState() => _CreateCotisationPageState();
}

class _CreateCotisationPageState extends State<CreateCotisationPage> {
  final _currentAmountController = TextEditingController();
  final _targetAmountController = TextEditingController();
  User? _user;

  @override
  void dispose() {
    _currentAmountController.dispose();
    _targetAmountController.dispose();
    super.dispose();
  }

  void _createCotisation() {
    final currentAmount = double.parse(_currentAmountController.text);
    final targetAmount = double.parse(_targetAmountController.text);

    // Validate input
    if (_user == null) {
      return;
    }

    // Create Cotisation object

    final cotisation = Cotisation(
      currentAmount: currentAmount,
      targetAmount: targetAmount,
      user: _user!,
    );

    // Save cotisation to Hive box
    final box = Hive.box<Cotisation>('cotisations');
    box.add(cotisation);

    // Show success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cotisation Created'),
        content: const Text('Cotisation successfully created.'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creer la cotisation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _currentAmountController,
              decoration: const InputDecoration(
                labelText: 'Somme',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _targetAmountController,
              decoration: const InputDecoration(
                labelText: 'Somme finale',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<User>(
              value: _user,
              onChanged: (value) {
                setState(() {
                  _user = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Utilisateur',
              ),
              items: Hive.box<User>('users').values.map((user) {
                return DropdownMenuItem<User>(
                  value: user,
                  child: Text(user.firstName),
                );
              }).toList(),
            ),
            if (_user != null) Text(_user!.firstName),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _createCotisation,
              child: const Text('Creer la Cotisation'),
            ),
          ],
        ),
      ),
    );
  }

  void _selectUser() async {
    List<User>? selectedUsers = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserListPage()),
    );
    if (selectedUsers != null) {
      setState(() {
        _user = selectedUsers.first;
      });
    }
  }
}
