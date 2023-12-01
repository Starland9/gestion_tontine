import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/operation/operation.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:hive/hive.dart';

class AddOperationDialog extends StatefulWidget {
  const AddOperationDialog(
      {super.key, this.deposit = true, required this.user});

  final bool deposit;
  final User user;

  @override
  State<AddOperationDialog> createState() => _AddOperationDialogState();
}

class _AddOperationDialogState extends State<AddOperationDialog> {
  final _numberController = TextEditingController();
  final _amountController = TextEditingController();
  final _typeController = TextEditingController();
  final _descriptionCotroller = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    _amountController.dispose();
    _typeController.dispose();
    _descriptionCotroller.dispose();
    super.dispose();
  }

  void _addOperation() {
    if (_numberController.text.isEmpty) {
      return;
    }

    // Create Account object
    final operation = Operation(
      number: _numberController.text.trim(),
      date: DateTime.now(),
      amount: double.tryParse(_amountController.text) ?? 0.0,
      type: widget.deposit ? "depot" : "retrait",
      user: widget.user,
      description: _descriptionCotroller.text,
    );

    // Save account to Hive box
    final box = Hive.box<Operation>('operations');
    box.add(operation);

    if (widget.deposit) {
      widget.user.amount += operation.amount;
    } else {
      widget.user.amount -= operation.amount;
    }
    try {
      widget.user.save();
    } catch (e) {
      print(e);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.deposit ? "Effectuer le depot" : "Effectuer la retrait"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(
                labelText: 'Numero',
              ),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Montant',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionCotroller,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              minLines: 2,
              maxLines: null,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _addOperation,
          child: const Text('Effectuer'),
        ),
      ],
    );
  }
}
