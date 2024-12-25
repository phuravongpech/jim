import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    list.addAll(
        widget.currentWorkout.getExercisesFromWorkout(workoutExercises));
    exerciseCardKeys.addAll(
        List.generate(list.length, (index) => GlobalKey<ExerciseCardState>()));
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

  void _showQuitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quit Workout'),
          content: const Text('Are you sure you want to quit the workout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('Quit', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Workout'),
          content: const Text('Are you sure you want to save the workout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveWorkout();
              },
              child: const Text('Save', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    logger.d(list.map((e) => e.exercise.name.toString()).toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Flat design
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: _showQuitDialog,
        ),
        centerTitle: true,
        title: Text(
          widget.currentWorkout.name,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt, color: Colors.black),
            onPressed: _showSaveDialog,
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
