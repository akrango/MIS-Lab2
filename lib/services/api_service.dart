import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> getJokeTypes() async {
    var response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/types'));
    return response;
  }

  static Future<http.Response> getJokes(String type) async {
    var response = await http.get(
        Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten'));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  static Future<Map<String, dynamic>> getRandomJoke() async {
    var response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}
