import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jim/data/workout_data.dart';
import 'package:jim/models/workout.dart';
import 'package:logger/logger.dart';
import 'widgets/workout_log_exercise_card.dart';

class WorkoutLogScreen extends StatelessWidget {
  final Workout currentWorkout;
  late final exerciseList =
      currentWorkout.getExercisesFromWorkout(workoutExercises);

  final log = Logger();

  late final list = currentWorkout.getWorkoutLogFromWorkoutExercise(
      workoutLogs, exerciseList);
  WorkoutLogScreen({super.key, required this.currentWorkout});

  @override
  Widget build(BuildContext context) {
    log.d('ex list : $exerciseList');
    log.d(list);
    String formattedDate = DateFormat('MMMM d, y').format(currentWorkout.date);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Workout Log',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (list.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    list.first.workoutExercise.workout.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Divider(thickness: 1, color: Colors.grey.shade300),
            const SizedBox(height: 10),
            exerciseList.isNotEmpty || list.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: exerciseList.length,
                      itemBuilder: (context, index) {
                        return WorkoutExerciseCard(
                          workoutExercise: exerciseList[index],
                          workoutLogs: list,
                        );
                      },
                    ),
                  )
                : const Center(child: Text('No data')),
          ],
        ),
      ),
    );
  }
}
