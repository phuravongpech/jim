import 'package:jim/models/workout.dart';

import '../models/exercise.dart';
import '../models/workout_exercise.dart';
import '../models/workout_log.dart';

final List<Exercise> exercises = [
  Exercise(
    name: 'Barbell Squat',
    description:
        'Compound lower body exercise targeting quads, hamstrings, and glutes',
    category: Category.strength,
  ),
  Exercise(
    name: 'Bench Press',
    description:
        'Compound upper body exercise targeting chest, triceps, and shoulders',
    category: Category.powerlifting,
  ),
  Exercise(
    name: 'Deadlift',
    description: 'Full-body compound movement targeting posterior chain',
    category: Category.powerlifting,
  ),
  Exercise(
    name: 'Running',
    description: 'Cardiovascular endurance exercise',
    category: Category.cardio,
  ),
  Exercise(
    name: 'Pull-ups',
    description: 'Bodyweight exercise targeting back and arm muscles',
    category: Category.cardio,
  ),
];

final List<Workout> workouts = [
  Workout(
    name: 'Leg Day Intense',
    description: 'Comprehensive lower body strength training',
    date: DateTime.now(),
    isCompleted: false,
    exercises: [
      exercises[0], // Barbell Squat
      exercises[2] // Deadlift
    ],
  ),
  Workout(
    name: 'Upper Body Power',
    description: 'Powerlifting focus on chest and pulling movements',
    date: DateTime.now().subtract(const Duration(days: 2)),
    isCompleted: true,
    exercises: [
      exercises[1], // Bench Press
      exercises[4] // Pull-ups
    ],
  ),
];

final List<WorkoutExercise> workoutExercises = [
  WorkoutExercise(
    workout: workouts[0],
    exercise: workouts[0].exercises[0], // Barbell Squat
    restTimeSecond: 120,
    set: 2,
  ),
  WorkoutExercise(
    workout: workouts[0],
    exercise: workouts[0].exercises[1], // Pull-ups
    restTimeSecond: 120,

    set: 2,
  ),
  WorkoutExercise(
    workout: workouts[1],
    exercise: workouts[1].exercises[0], // Bench Press
    restTimeSecond: 120,

    set: 2,
  ),
  WorkoutExercise(
    workout: workouts[1],
    exercise: workouts[1].exercises[1], // Deadlift
    restTimeSecond: 120,

    set: 2,
  ),
];

final List<WorkoutLog> workoutLogs = [];

// final List<WorkoutLog> workoutLogs = [
//   // Logs for Barbell Squat (Workout 0, Exercise 0)
//   WorkoutLog(
//     workoutExercise: workoutExercises[0],
//     weight: 20,
//     rep: 10,
//     setNumber: 1,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[0],
//     weight: 22.5,
//     rep: 9,
//     setNumber: 2,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[0],
//     weight: 25,
//     rep: 8,
//     setNumber: 3,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[0],
//     weight: 0,
//     rep: 0,
//     setNumber: 4,
//   ),

//   // Logs for Pull-ups (Workout 0, Exercise 1)
//   WorkoutLog(
//     workoutExercise: workoutExercises[1],
//     weight: 0, // Bodyweight exercise
//     rep: 10,
//     setNumber: 1,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[1],
//     weight: 0,
//     rep: 9,
//     setNumber: 2,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[1],
//     weight: 0,
//     rep: 8,
//     setNumber: 3,
//   ),

//   // Logs for Bench Press (Workout 1, Exercise 0)
//   WorkoutLog(
//     workoutExercise: workoutExercises[2],
//     weight: 20,
//     rep: 10,
//     setNumber: 1,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[2],
//     weight: 22.5,
//     rep: 9,
//     setNumber: 2,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[2],
//     weight: 25,
//     rep: 8,
//     setNumber: 3,
//   ),

//   // Logs for Deadlift (Workout 1, Exercise 1)
//   WorkoutLog(
//     workoutExercise: workoutExercises[3],
//     weight: 20,
//     rep: 10,
//     setNumber: 1,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[3],
//     weight: 22.5,
//     rep: 9,
//     setNumber: 2,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[3],
//     weight: 25,
//     rep: 8,
//     setNumber: 3,
//   ),
// ];
