import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/cotisation/cotisation.dart';

class CreateCotisationPage extends StatefulWidget {
  const CreateCotisationPage({super.key, required this.user});

  final User user;

  @override
  State<CreateCotisationPage> createState() => _CreateCotisationPageState();
}

class _CreateCotisationPageState extends State<CreateCotisationPage> {
  final _currentAmountController = TextEditingController();
  final _targetAmountController = TextEditingController();
  late User _user;

  @override
  void initState() {
    _user = widget.user;
    super.initState();
  }

  @override
  void dispose() {
    _currentAmountController.dispose();
    _targetAmountController.dispose();
    super.dispose();
  }

  void _createCotisation() {
    final currentAmount = double.parse(_currentAmountController.text);
    final targetAmount = double.parse(_targetAmountController.text);

    // Create Cotisation object

    final cotisation = Cotisation(
      currentAmount: currentAmount,
      targetAmount: targetAmount,
      user: _user,
    );

    // Save cotisation to Hive box
    final box = Hive.box<Cotisation>('cotisations');
    box.add(cotisation);

    // Show success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cotisation cree'),
        content: const Text(' La cotisation a bien ete cree'),
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
    return AlertDialog(
      title: const Text('Creer la cotisation'),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
            // DropdownButtonFormField<User>(
            //   value: _user,
            //   onChanged: (value) {
            //     setState(() {
            //       _user = value;
            //     });
            //   },
            //   decoration: const InputDecoration(
            //     labelText: 'Utilisateur',
            //   ),
            //   items: Hive.box<User>('users').values.map((user) {
            //     return DropdownMenuItem<User>(
            //       value: user,
            //       child: Text(user.firstName),
            //     );
            //   }).toList(),
            // ),
            Text(_user.fullName),
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

  // void _selectUser() async {
  //   List<User>? selectedUsers = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const UserListPage()),
  //   );
  //   if (selectedUsers != null) {
  //     setState(() {
  //       _user = selectedUsers.first;
  //     });
  //   }
  // }
}
