import 'package:explorer/data/models/caracter_model.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterCard({super.key, required this.character, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Image.network(character.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(character.name),
        subtitle: Text('Status: ${character.status}'),
        onTap: onTap,
      ),
    );
  }
}