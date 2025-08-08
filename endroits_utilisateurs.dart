import 'package:flutter_riverpod/flutter_riverpod.dart';

// MODELE : Représente un endroit avec un nom, un identifiant et une image locale
class Endroit {
  final int? id;
  final String nom;
  final String imagePath;

  Endroit({
    this.id,
    required this.nom,
    this.imagePath = '',
  });

  //  Conversion vers une Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'imagePath': imagePath,
    };
  }

  // Reconstruction depuis SQLite
  factory Endroit.fromMap(Map<String, dynamic> map) {
    return Endroit(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      imagePath: map['imagePath'] as String? ?? '',
    );
  }
}

//  LOGIQUE : Gère la liste d’endroits en mémoire 
class EndroitsUtilisateur extends StateNotifier<List<Endroit>> {
  EndroitsUtilisateur() : super([]);

  void ajoutEndroit(String nom, {String imagePath = ''}) {
    final nouveauEndroit = Endroit(nom: nom, imagePath: imagePath);
    state = [nouveauEndroit, ...state];
  }
}

// PROVIDER global Riverpod
final endroitsProvider = StateNotifierProvider<EndroitsUtilisateur, List<Endroit>>(
  (ref) => EndroitsUtilisateur(),
);
