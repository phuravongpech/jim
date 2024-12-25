import 'package:jim/data/workout_data.dart';
import 'package:jim/utils/utils.dart';

class User {
  final String id; // Unique identifier for the exercise
  String name;
  String? description;

  User(
      {String? id, // Optional parameter
      required this.name,
      this.description})
      : id = id ?? Utils.generateUuid(); // Generate a new UUID if not provided

  int getWorkoutCompleted() {
    int completedWorkouts =
        workouts.where((workout) => workout.isCompleted).length;

    return completedWorkouts;
  }

  @override
  String toString() {
    return 'User{\n  name: $name,\n  description: $description,}';
  }
}
