import 'package:flutter/material.dart';
import 'package:gestion_endroits_favoris/providers/endroits_utilisateurs.dart';


class EndroitDetail extends StatelessWidget {
  final Endroit endroit;

  const EndroitDetail({super.key, required this.endroit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(endroit.nom)),
      body: Center(
        child: Text(
          endroit.nom,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
