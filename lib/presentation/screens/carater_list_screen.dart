import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod/flutter_riverpod.dart';
import 'package:explorer_app/presentation/providers/character_provider.dart';
import 'package:explorer_app/presentation/screens/character_detail_screen.dart';
import 'package:explorer_app/presentation/widgets/character_card.dart';

class CharacterListScreen extends ConsumerStatefulWidget {
  const CharacterListScreen({super.key});

  @override
  ConsumerState<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends ConsumerState<CharacterListScreen> {
  final _scrollController = ScrollController();
  final _nameController = TextEditingController();
  String? _selectedStatus;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      ref.read(characterProvider.notifier).loadCharacters();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(characterProvider.notifier).applyFilters(value, _selectedStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final charactersState = ref.watch(characterProvider);
    final notifier = ref.read(characterProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('ExplorerApp')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Search by name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  hint: const Text('Status'),
                  value: _selectedStatus,
                  items: ['Alive', 'Dead', 'unknown'].map((status) {
                    return DropdownMenuItem(value: status, child: Text(status));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedStatus = value);
                    notifier.applyFilters(_nameController.text, value);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: charactersState.when(
              data: (characters) => ListView.builder(
                controller: _scrollController,
                itemCount: characters.length + (notifier.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == characters.length && notifier.hasMore) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final character = characters[index];
                  return CharacterCard(
                    character: character,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailScreen(character: character),
                      ),
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $error'),
                    ElevatedButton(
                      onPressed: () => notifier.loadCharacters(reset: true),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}