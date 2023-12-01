import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:gestion_tontine/screens/operation/operations_page.dart';

import 'operation_create_page.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key, required this.user});

  final User user;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Effectuer une transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Solde"),
                Text(
                  "${widget.user.amount} FCFA",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _deposit,
                    icon: const Icon(Icons.add_circle),
                    label: const Text("Deposer"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _withdraw,
                    icon: const Icon(Icons.remove_circle),
                    label: const Text("Retirer"),
                  ),
                )
              ],
            ),
            const Expanded(child: OperationsPage())
          ],
        ),
      ),
    );
  }

  void _deposit() {
    showDialog(
      context: context,
      builder: (context) =>
          AddOperationDialog(deposit: true, user: widget.user),
    );
  }

  void _withdraw() {
    showDialog(
      context: context,
      builder: (context) =>
          AddOperationDialog(deposit: false, user: widget.user),
    );
  }
}
