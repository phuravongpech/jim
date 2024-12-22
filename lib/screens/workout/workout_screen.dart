import 'package:flutter/material.dart';
import 'package:jim/data/workout_data.dart';
import 'package:jim/models/workout_exercise.dart';
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
  final List<WorkoutExercise> list = [];
  final List<WorkoutLog> logDataList = [];
  final logger = Logger();
  final List<GlobalKey<ExerciseCardState>> exerciseCardKeys = [];

  @override
  void initState() {
    super.initState();
    list.addAll(widget.currentWorkout.getExercisesFromWorkout(workoutExercises));
    exerciseCardKeys.addAll(List.generate(list.length, (index) => GlobalKey<ExerciseCardState>()));
  }

  void _saveWorkout() {
    logDataList.clear();
    for (var i = 0; i < exerciseCardKeys.length; i++) {
      final logs = exerciseCardKeys[i].currentState?.validateDataFromEachSet();
      if (logs != null) {
        logDataList.addAll(logs);
      }
    }

    Navigator.pop(context, logDataList);
    logger.d(logDataList);
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
          key: exerciseCardKeys[index],
          currentWorkoutExercise: list[index],
        ),
      ),
    );
  }
}
