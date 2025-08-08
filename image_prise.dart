import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePrise extends StatefulWidget {
  final void Function(File image) onPhotoSelectionnee;

  const ImagePrise({super.key, required this.onPhotoSelectionnee});

  @override
  State<ImagePrise> createState() => _ImagePriseState();
}

class _ImagePriseState extends State<ImagePrise> {
  // ├─ Propriété _photoSelectionnee (Type File?)
  File? _photoSelectionnee;

  // ├─ Méthode _prendrePhoto
  Future<void> _prendrePhoto() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (photo == null) return;

    final imageFinale = File(photo.path);
    setState(() {
      _photoSelectionnee = imageFinale;
    });

    widget.onPhotoSelectionnee(imageFinale);
  }

  // └─ Méthode build
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: _photoSelectionnee == null
          // ├─ Condition : Si _photoSelectionnee est nul
          ? TextButton.icon(
              // └─ TextButton.icon
              icon: const Icon(Icons.camera),
              label: const Text("Prendre photo"),
              // └─ onPressed (_prendrePhoto)
              onPressed: _prendrePhoto,
            )
          // └─ Sinon (Si _photoSelectionnee contient une image)
          : GestureDetector(
              // └─ GestureDetector
              onTap: _prendrePhoto,
              child: Image.file(
                _photoSelectionnee!,
                // └─ Image.file (Affiche l'image capturée)
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
    );
  }
}
