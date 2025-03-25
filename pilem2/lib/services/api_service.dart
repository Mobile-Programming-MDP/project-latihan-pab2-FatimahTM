import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "d720154fcaa47d1ba4233673ce24e2e9";

  // Fungsi untuk mengambil film yang sedang tayang
  Future<List<Map<String, dynamic>>> getAllMovies() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey"),
        headers: {"Accept": "application/json"},
      );

      print("Response dari API getAllMovies: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        print("Error getAllMovies: ${response.statusCode} - ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      print("Exception di getAllMovies: $e");
      return [];
    }
  }

  // Fungsi untuk mengambil film yang trending dalam seminggu
  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/trending/movie/week?api_key=$apiKey"),
        headers: {"Accept": "application/json"},
      );

      print("Response dari API getTrendingMovies: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        print("Error getTrendingMovies: ${response.statusCode} - ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      print("Exception di getTrendingMovies: $e");
      return [];
    }
  }

  // Fungsi untuk mengambil film yang populer
  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"),
        headers: {"Accept": "application/json"},
      );

      print("Response dari API getPopularMovies: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        print("Error getPopularMovies: ${response.statusCode} - ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      print("Exception di getPopularMovies: $e");
      return [];
    }
  }

  // Fungsi untuk mencari film berdasarkan query pengguna
  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/search/movie?query=$query&api_key=$apiKey"),
        headers: {"Accept": "application/json"},
      );

      print("Response dari API searchMovies: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        print("Error searchMovies: ${response.statusCode} - ${response.reasonPhrase}");
        return [];
      }
    } catch (e) {
      print("Exception di searchMovies: $e");
      return [];
    }
  }
}
