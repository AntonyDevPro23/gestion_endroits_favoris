import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/endroits_utilisateurs.dart';

class AjoutEndroit extends ConsumerStatefulWidget {
  const AjoutEndroit({super.key});

  @override
  ConsumerState<AjoutEndroit> createState() => _AjoutEndroitState();
}

class _AjoutEndroitState extends ConsumerState<AjoutEndroit> {
  final _nomController = TextEditingController();

  void _enregistreEndroit() {
    final nomSaisi = _nomController.text;
    if (nomSaisi.isEmpty) return;

    ref.read(endroitsProvider.notifier).ajoutEndroit(nomSaisi);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajout d'un nouveau endroit")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: "Nom de l'endroit"),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _enregistreEndroit,
              icon: const Icon(Icons.add),
              label: const Text("Ajouter un nouveau endroit"),
            ),
          ],
        ),
      ),
    );
  }
}

