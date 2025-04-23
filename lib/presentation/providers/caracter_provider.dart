import 'package:explorer/data/models/caracter_model.dart';
import 'package:explorer/data/repositories/carater_repository.dart';
import 'package:riverpod/riverpod.dart';
import '../../data/services/api_service.dart';

final characterRepositoryProvider = Provider((ref) => CharacterRepository(ApiService()));

final characterProvider = StateNotifierProvider<CharacterNotifier, AsyncValue<List<Character>>>((ref) {
  return CharacterNotifier(ref.read(characterRepositoryProvider));
});

class CharacterNotifier extends StateNotifier<AsyncValue<List<Character>>> {
  final CharacterRepository _repository;
  int _page = 1;
  String? _nameFilter;
  String? _statusFilter;
  bool _hasMore = true;

  CharacterNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadCharacters();
  }

  Future<void> loadCharacters({bool reset = false}) async {
    if (!_hasMore && !reset) return;

    if (reset) {
      _page = 1;
      state = const AsyncValue.loading();
    }

    try {
      final characters = await _repository.getCharacters(_page, name: _nameFilter, status: _statusFilter);
      if (characters.isEmpty) {
        _hasMore = false;
      } else {
        final currentList = reset ? [] : (state.value ?? []);
        state = AsyncValue.data([...currentList, ...characters]);
        _page++;
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void applyFilters(String? name, String? status) {
    _nameFilter = name?.isEmpty ?? true ? null : name;
    _statusFilter = status?.isEmpty ?? true ? null : status;
    loadCharacters(reset: true);
  }
}