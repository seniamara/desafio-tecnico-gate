import 'package:dio/dio.dart';
import 'package:explorer/data/models/caracter_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<CharacterModel>> fetchCharacters(int page, {String? name, String? status}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/character',
        queryParameters: {
          'page': page,
          if (name != null) 'name': name,
          if (status != null) 'status': status,
        },
      );
      final List<dynamic> results = response.data['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load characters: $e');
    }
  }
}