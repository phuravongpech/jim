import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jim/models/exercise.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExerciseService {
  static const String baseUrl = 'https://exercisedb.p.rapidapi.com';
  static final String apiKey =
      dotenv.env['API_KEY']!; // Replace with your API key

  Future<List<Exercise>> getExercises() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/exercises'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Exercise.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (e) {
      throw Exception('Error fetching exercises: $e');
    }
  }
}
