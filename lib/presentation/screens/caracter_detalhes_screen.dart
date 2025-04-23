import 'package:explorer/data/models/caracter_model.dart';
import 'package:flutter/material.dart';
class CharacterDetailScreen extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(character.image, height: 200)),
            const SizedBox(height: 16),
            Text('Name: ${character.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Status: ${character.status}'),
            Text('Species: ${character.species}'),
            Text('Gender: ${character.gender}'),
            Text('Location: ${character.location}'),
          ],
        ),
      ),
    );
  }
}