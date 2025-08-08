import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_endroits_favoris/helpers/db_helper.dart';
// ignore: unused_import
import 'package:gestion_endroits_favoris/modele/endroit.dart';
import 'dart:io';

import 'package:gestion_endroits_favoris/providers/endroits_utilisateurs.dart';

//  Provider qui récupère les endroits depuis SQLite
final endroitsBaseProvider = FutureProvider<List<Endroit>>((ref) async {
  return await DbHelper.fetchEndroits(); // 
});

class ListeEndroits extends ConsumerWidget {
  const ListeEndroits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final endroitsAsync = ref.watch(endroitsBaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Endroits Favoris'),
        backgroundColor: const Color.fromARGB(255, 224, 171, 25),
      ),
      body: endroitsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => const Center(child: Text("Erreur lors du chargement.")),
        data: (endroits) {
          if (endroits.isEmpty) {
            return const Center(child: Text("Aucun endroit pour le moment."));
          }

          return ListView.builder(
            itemCount: endroits.length,
            itemBuilder: (context, index) {
              final endroit = endroits[index];

              return Dismissible(
                key: Key(endroit.id.toString()),
                background: Container(color: Colors.red),
                direction: DismissDirection.endToStart,
                onDismissed: (_) async {
                  var id = endroit.id;
                  await DbHelper.supprimerEndroit(id!); 
                  ref.invalidate(endroitsBaseProvider); 
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: endroit.imagePath.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(endroit.imagePath),
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.place, size: 48),
                    title: Text(endroit.nom),
                    subtitle: Text("ID : ${endroit.id}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigation future vers détails de l’endroit
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
