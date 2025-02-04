import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jim/models/exercise.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:jim/services/cache_service.dart';
import 'package:logger/logger.dart';

class ExerciseService {
  // final CacheService _cacheService = CacheService();
  final log = Logger();

  Future<List<Exercise>> getExercises(
      {required int page,
      required int limit,
      bool forceRefresh = false,
      required String bodyPart}) async {
    try {
      const String baseUrl = 'https://exercisedb.p.rapidapi.com';
      final String apiKey = dotenv.env['API_KEY']!;

      final response = await http.get(
        Uri.parse(
            '$baseUrl/exercises/bodyPart/$bodyPart?offset=${page * limit}&limit=$limit'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final exercises = data.map((json) => Exercise.fromJson(json)).toList();
        return exercises;
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (e) {
      throw Exception('Error fetching exercises: $e');
    }
  }
}
