import 'package:flutter/material.dart';
import 'package:gestion_tontine/models/cotisation/cotisation.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:gestion_tontine/screens/cotisation/create_cotisation_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CotisationPage extends StatelessWidget {
  const CotisationPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Cotisation>('cotisations');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Cotisations'),
      ),
      body: ValueListenableBuilder<Box<Cotisation>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          final cotisations = box.values
              .toList()
              .reversed
              .where((element) => element.user == user)
              .toList();

          if (cotisations.isEmpty) {
            return const Center(
              child: Text('Aucune cotisation'),
            );
          }

          return ListView.builder(
            itemCount: cotisations.length,
            itemBuilder: (context, index) {
              final cotisation = cotisations[index];
              return ListTile(
                leading: const Icon(
                  Icons.attach_money,
                  color: Colors.blue,
                ),
                title: Text('Somme: ${cotisation.currentAmount} FCFA'),
                subtitle: Text(
                    "Montant total: ${cotisation.targetAmount.toStringAsFixed(2)} FCFA"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    box.deleteAt(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CreateCotisationPage(
              user: user,
            ),
          );
        },
      ),
    );
  }
}
