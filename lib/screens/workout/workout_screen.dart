import 'package:flutter/material.dart';
import 'package:jim/data/workout_data.dart';
import 'package:logger/logger.dart';

import '../../models/workout.dart';
import '../../models/workout_log.dart';
import 'widgets/exercise_card.dart';

class WorkoutScreen extends StatefulWidget {
  final Workout currentWorkout;

  const WorkoutScreen({super.key, required this.currentWorkout});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late final list =
      widget.currentWorkout.getExercisesFromWorkout(workoutExercises);
  final List<WorkoutLog> logDataList = [];
  final logger = Logger();

  void _saveWorkout() {
    // // Validate that logs are not empty before saving
    // if (logDataList.isNotEmpty) {
    //   Navigator.pop(context, logDataList);
    // } else {
    //   // Optional: Show a dialog or snackbar that no logs have been recorded
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content: Text('Please log at least one set before saving')),
    //   );
    // }
    logger.d(logDataList.map((e) => e.workoutExercise.exercise).toString());
    Navigator.pop(context, logDataList);
    // print(
    //     'log data list = ${}');
  }

  @override
  Widget build(BuildContext context) {
    logger.d(list.map((e) => e.exercise.name.toString()).toString());
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logos/logo2.png', width: 40, height: 40),
        backgroundColor: const Color(0xFF05b6ca),
        title: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        actions: [
          Row(
            children: [
              const Icon(Icons.save_alt_sharp),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: _saveWorkout,
                child: const Text('Save'),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => ExerciseCard(
          currentWorkoutExercise: list[index],
          addLog: (data) {
            setState(() {
              logDataList.addAll(data);
            });
          },
        ),
      ),
    );
  }
}

