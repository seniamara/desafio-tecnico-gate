import 'package:explorer/data/models/caracter_model.dart';
import '../services/api_service.dart';

class CharacterRepository {
  final ApiService _apiService;

  CharacterRepository(this._apiService);

  Future<List<CharacterModel>> getCharacters(int page, {String? name, String? status}) {
    return _apiService.fetchCharacters(page, name: name, status: status);
  }
}