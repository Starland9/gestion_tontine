import 'package:flutter/material.dart';

class TransactionDemandDialog extends StatefulWidget {
  const TransactionDemandDialog({super.key});

  @override
  State<TransactionDemandDialog> createState() =>
      _TransactionDemandDialogState();
}

class _TransactionDemandDialogState extends State<TransactionDemandDialog> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Effectuer'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Montant',
              ),
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
          onPressed: _confirm,
          child: const Text('Ajouter'),
        ),
      ],
    );
  }

  void _confirm() {
    if (_amountController.text.isEmpty) {
      return;
    }

    // Create Account object
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    Navigator.pop(context, amount);
  }
}
