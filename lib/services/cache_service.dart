// lib/services/cache_service.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:jim/models/exercise.dart';
import 'package:logger/logger.dart';

class CacheService {
  static const String exerciseBoxName = 'favorites';

  final log = Logger();

  // Initialize Hive
  static Future<void> init() async {
    if (kIsWeb) {
      // Initialize for web
      await Hive.initFlutter();
    } else {
      // Initialize for mobile
      await Hive.initFlutter();
    }

    // Register adapter
    if (!Hive.isAdapterRegistered(0)) {
      // 0 is the typeId we defined in Exercise class
      Hive.registerAdapter(ExerciseAdapter());
    }

    await Hive.openBox<Exercise>(exerciseBoxName);
  }

  // save as fav exercises
  Future<void> saveFavorite(Exercise exercise) async {
    final box = Hive.box<Exercise>(exerciseBoxName);

    await box.put(exercise.id, exercise);
    log.d('$exercise is logged');
  }

  //remove from favorite
  Future<void> removeFavorite(String exerciseId) async {
    final box = Hive.box<Exercise>(exerciseBoxName);
    await box.delete(exerciseId);
    log.d('$exerciseId is removed');
  }

  // Get cached exercises
  Future<List<Exercise>> getFavorites() async {
    try {
      final box = Hive.box<Exercise>('favorites');
      log.d('get favorite cached ex');
      if (box.isEmpty) {
        return [];
      }
      return box.values.toList();
    } catch (e) {
      Logger().e('Error getting cached exercises: $e');
      return [];
    }
  }

  // Clear cache
  Future<void> clearCache() async {
    final box = Hive.box<Exercise>(exerciseBoxName);
    await box.clear();
  }
}
