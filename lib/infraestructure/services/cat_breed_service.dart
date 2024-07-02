import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';

class CatBreedService {
  static const String _url = 'https://api.thecatapi.com/v1/breeds';

  Future<List<CatBreed>> fetchCatBreeds() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CatBreed.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }
}
