import 'dart:convert';
import 'package:http/http.dart' as http;

class CatImageService {
  static const String _url = 'https://api.thecatapi.com/v1/images/search';

  Future<String> fetchCatImage() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data[0]['url'];
    } else {
      throw Exception('Failed to load cat image');
    }
  }
}
