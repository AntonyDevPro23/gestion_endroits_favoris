import 'package:flutter/material.dart';
import 'package:gestion_endroits_favoris/providers/endroits_utilisateurs.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../helpers/db_helper.dart';
// ignore: unused_import
import '../modele/endroit.dart';

class AjoutEndroit extends StatefulWidget {
  const AjoutEndroit({super.key});

  @override
  State<AjoutEndroit> createState() => _AjoutEndroitState();
}

class _AjoutEndroitState extends State<AjoutEndroit> {
  final TextEditingController _nomController = TextEditingController();
  File? _imageFile;

  Future<void> _prendrePhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    } else {
      _afficherSnackBar("Aucune photo n’a été prise.");
    }
  }

  void _supprimerImage() {
    setState(() {
      _imageFile = null;
    });
  }

  void _sauvegarderEndroit() async {
    final nom = _nomController.text.trim();

    if (nom.isEmpty) {
      _afficherSnackBar("Veuillez saisir un nom.");
      return;
    }

    final nouvelEndroit = Endroit(
      nom: nom,
      imagePath: _imageFile?.path ?? '',
    );

    try {
      await DbHelper.insertEndroit(nouvelEndroit);
      Navigator.of(context).pop(nouvelEndroit);
    } catch (e) {
      _afficherSnackBar("Une erreur est survenue lors de l’enregistrement.");
      debugPrint("Erreur DbHelper : $e");
    }
  }

  void _afficherSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajout d'un nouvel endroit"),
        backgroundColor: const Color.fromARGB(255, 224, 171, 25),
        foregroundColor: const Color.fromARGB(255, 238, 238, 238),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom de l’endroit',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              IntrinsicWidth(
                child: ElevatedButton.icon(
                  onPressed: _prendrePhoto,
                  icon: const Icon(Icons.chrome_reader_mode),
                  label: const Text("Prendre photo"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              if (_imageFile != null) ...[
                const SizedBox(height: 16),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _imageFile!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: _supprimerImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _sauvegarderEndroit,
                icon: const Icon(Icons.add),
                label: const Text("Ajouter l’endroit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 103, 152, 197),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



