// ignore_for_file: avoid_print

import 'package:jim/models/exercise.dart';
import 'package:jim/utils/utils.dart';

import 'workout_exercise.dart';
import 'workout_log.dart';

// void main() {
//   List<WorkoutExercise> we1 =
//       getExercisesFromWorkout(workoutExercises, workouts[0]);
//   print(we1);

//   var list = getWorkoutLogFromWorkoutExercise(workoutLogs, we1);
//   print(list.map((e) => e.workoutExercise.exercise.name));
// }

class Workout {
  final String id; // Unique identifier for the workout
  final String name;
  final String description;
  final DateTime date;
  bool isCompleted;
  final List<Exercise> exercises;

  Workout({
    String? id, // Optional parameter
    required this.name,
    required this.description,
    required this.exercises,
    required this.date,
    this.isCompleted = false,
  }) : id = id ?? Utils.generateUuid(); // Generate a new UUID if not provided

  bool validate() => exercises.isNotEmpty;

  void completeWorkout() => isCompleted = true;

  @override
  String toString() {
    return 'Workout{id: $id, name: $name, description: $description, date: $date, isCompleted: $isCompleted, exercises: $exercises}';
  }

  List<WorkoutExercise> getExercisesFromWorkout(
      List<WorkoutExercise> workoutExercise) {
    return workoutExercise.where((we) => we.workout.id == id).toList();
  }

  List<WorkoutLog> getWorkoutLogFromWorkoutExercise(
      List<WorkoutLog> workoutLogs, List<WorkoutExercise> workoutExercises) {
    //create a datatype set to store workoutexercise id
    Set<String> workoutExerciseIds =
        workoutExercises.map((we) => we.id).toSet();

    //filter it
    var list = workoutLogs
        .where((workoutLog) =>
            workoutExerciseIds.contains(workoutLog.workoutExercise.id))
        .toList();

    return list;
  }
}






//w1 ex1 set1 30reps x 30kg weight 120sec rest



// List<Workout> workouts = [
//   workout,
// // workout2
// ];

// Workout workout = Workout(
//     name: 'leg',
//     description: 'leg bitchhhhhh',
//     date: DateTime.now(),
//     isCompleted: false,
//     exercises: [
//       Exercise(
//           name: 'Leg Press',
//           description: 'leg press',
//           category: Category.strength),
//       Exercise(
//           name: 'bench Press',
//           description: 'bench press',
//           category: Category.strength),
//     ]);
// Workout workout2 = Workout(
//     name: 'chest',
//     description: 'chest bitchhhhhh',
//     date: DateTime.utc(2024, 10, 17),
//     isCompleted: false,
//     exercises: [
//       Exercise(
//           name: 'Leg Press',
//           description: 'leg press',
//           category: Category.strength),
//       Exercise(
//           name: 'bench Press',
//           description: 'bench press',
//           category: Category.strength),
//     ]);

// WorkoutExercise workoutExercise =
//     WorkoutExercise(workout: workout, exercise: workout.exercises[1], set: 5);

// List<WorkoutLog> workoutLogs = [
//   WorkoutLog(
//       workoutExercise: workoutExercise,
//       weight: 20,
//       rep: 12,
//       setNumber: 1,
//       restTimeSecond: 120),
//   WorkoutLog(
//       workoutExercise: workoutExercise,
//       weight: 20,
//       rep: 11,
//       setNumber: 2,
//       restTimeSecond: 120),
//   WorkoutLog(
//       workoutExercise: workoutExercise,
//       weight: 20,
//       rep: 10,
//       setNumber: 3,
//       restTimeSecond: 120),
// ];