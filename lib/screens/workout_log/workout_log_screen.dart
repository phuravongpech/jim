import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jim/data/workout_data.dart';
import 'package:jim/models/workout.dart';

import 'widgets/workout_exercise_card.dart';

class WorkoutLogScreen extends StatelessWidget {
  final Workout currentWorkout;
  late final exerciseList =
      currentWorkout.getExercisesFromWorkout(workoutExercises);
  late final list = currentWorkout.getWorkoutLogFromWorkoutExercise(
      workoutLogs, exerciseList);
  WorkoutLogScreen({super.key, required this.currentWorkout});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM d, y').format(currentWorkout.date);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05b6ca),
        centerTitle: true,
        title: Image.asset(
          'assets/logos/logo1.png',
          width: 80,
        ),
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    // workoutLogs[1].workoutExercise.workout.id,
                    list.first.workoutExercise.workout.name.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  formattedDate,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView(
              children: [
                ...exerciseList.map((exercise) => WorkoutExerciseCard(
                      workoutExercise: exercise,
                      workoutLogs: list,
                    )),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
