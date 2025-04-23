import 'dart:async';
import 'package:explorer/presentation/providers/caracter_provider.dart';
import 'package:explorer/presentation/screens/caracter_detalhes_screen.dart';
import 'package:explorer/presentation/widgets/caracter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterListScreen extends ConsumerStatefulWidget {
  const CharacterListScreen({super.key});

  @override
  ConsumerState<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends ConsumerState<CharacterListScreen> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _nameController = TextEditingController();
  String? _selectedStatus;
  Timer? _debounce;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _showDropdown = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
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
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(characterProvider.notifier).applyFilters(value, _selectedStatus);
    });
  }

  void _toggleDropdown() {
    setState(() => _showDropdown = !_showDropdown);
  }

  @override
  Widget build(BuildContext context) {
    final charactersState = ref.watch(characterProvider);
    final notifier = ref.read(characterProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.explore, color: Colors.green),
        title: const Text('ExplorerApp', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: _showDropdown ? null : 'Pesquisar por nome',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFFA0A0A0)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_list, color: Color(0xFFA0A0A0)),
                      onPressed: _toggleDropdown,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFFCF6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: _showDropdown ? Colors.black : Colors.transparent),
                    ),
                  ),
                  onChanged: _onSearchChanged,
                ),
                if (_showDropdown)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedStatus,
                      decoration: const InputDecoration.collapsed(hintText: ''),
                      items: const [
                        DropdownMenuItem(value: 'Alive', child: Text('Vivo')),
                        DropdownMenuItem(value: 'Dead', child: Text('Morto')),
                        DropdownMenuItem(value: 'unknown', child: Text('Desconhecido')),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedStatus = value);
                        notifier.applyFilters(_nameController.text, value);
                      },
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: charactersState.when(
              data: (characters) => ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                itemCount: characters.length + (notifier.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == characters.length && notifier.hasMore) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
                            const SizedBox(width: 12),
                            Text('Carregando mais personagens...', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                          ],
                        ),
                      ),
                    );
                  }
                  final character = characters[index];
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: CharacterCard(
                      character: character,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharacterDetailScreen(character: character),
                        ),
                      ),
                    ),
                  );
                },
              ),
              loading: () => Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                  child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
                ),
              ),
              error: (error, _) => Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      color: Colors.white,
                     // elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 48),
                            const SizedBox(height: 16),
                            Text('Erro: $error', style: TextStyle(fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                            const SizedBox(height: 8),
                            Text('Verifique sua conexão e tente novamente.', style: TextStyle(fontSize: 14, color: Colors.grey[600]), textAlign: TextAlign.center),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () => notifier.loadCharacters(reset: true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[600],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
                              label: const Text('Tentar Novamente', style: TextStyle(color: Colors.white, fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
