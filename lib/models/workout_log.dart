import 'workout_exercise.dart';
import 'package:jim/utils/utils.dart';

class WorkoutLog {
  final String id; // Unique identifier for the workout log
  final WorkoutExercise workoutExercise;
  late double? weight;
  late int? rep;
  final int setNumber;

  WorkoutLog({
    String? id, // Optional parameter
    required this.workoutExercise,
    this.weight,
    this.rep,
    required this.setNumber,
  }) : id = id ?? Utils.generateUuid(); // Generate a new UUID if not provided

  @override
  String toString() {
    return 'WorkoutLog{id: $id, workoutExercise: ${workoutExercise.exercise.name}, weight: $weight, rep: $rep, setNumber: $setNumber}';
  }
}