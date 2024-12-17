import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "";

  Future<List<dynamic>> fetchBooks(String query) async {
    final response = await http.get(Uri.parse(baseUrl + query));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['items']; // Returns the list of books
    } else {
      throw Exception('Failed to load books');
    }
  }
}
