import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_endroits_favoris/vue/endroits_interface.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Endroits favoris',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const EndroitsInterface(),
    );
  }
}




