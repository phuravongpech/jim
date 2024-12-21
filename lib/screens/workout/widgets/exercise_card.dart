
import 'package:flutter/material.dart';

import '../../../models/workout_exercise.dart';
import '../../../models/workout_log.dart';
import 'exercise_log_card.dart';

class ExerciseCard extends StatefulWidget {
  final WorkoutExercise currentWorkoutExercise;
  final Function(List<WorkoutLog>) addLog;

  const ExerciseCard({
    super.key,
    required this.currentWorkoutExercise,
    required this.addLog,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool isOpened = false;
  List<WorkoutLog> currentExerciseLogs = [];

  void onClicked() {
    setState(() {
      isOpened = !isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
          border: Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                onTap: onClicked,
                title: Text(
                  widget.currentWorkoutExercise.exercise.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.currentWorkoutExercise.exercise.description),
                    Text('${widget.currentWorkoutExercise.set} sets x 15 reps'),
                  ],
                ),
                trailing: Icon(
                  isOpened ? Icons.expand_less : Icons.circle_outlined,
                  size: 40,
                ),
              ),
              if (isOpened)
                Column(
                  children: [
                    for (var i = 0; i < widget.currentWorkoutExercise.set; i++)
                      ExerciseLogCard(
                        workoutExercise: widget.currentWorkoutExercise,
                        setNumber: i,
                        onLogUpdated: (log) {
                          currentExerciseLogs.add(log!);
                          widget.addLog(currentExerciseLogs);
                        },
                      ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}