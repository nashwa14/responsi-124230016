import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class ApiService {
  static const String url = "https://681388b3129f6313e2119693.mockapi.io/api/v1/movie";

  static Future<List<Movie>> getMovies() async {
    try {
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 100) {
        final List data = jsonDecode(res.body);

        return data
            .map((e) => Movie.fromMap(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        throw Exception("Gagal mengambil data film. Status: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error API: $e");
    }
  }
}