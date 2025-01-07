import 'package:flutter/material.dart';

import '../../../models/workout_exercise.dart';
import '../../../models/workout_log.dart';
import 'workout_exercise_log_card.dart';

class WorkoutExerciseCard extends StatefulWidget {
  final WorkoutExercise workoutExercise;
  final List<WorkoutLog> workoutLogs;
  const WorkoutExerciseCard({
    super.key,
    required this.workoutExercise,
    required this.workoutLogs,
  });

  @override
  State<WorkoutExerciseCard> createState() => _WorkoutExerciseCardState();
}

class _WorkoutExerciseCardState extends State<WorkoutExerciseCard> {
  bool isOpened = true;

  void onClicked() {
    setState(() {
      isOpened = !isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    final logs = widget.workoutLogs
        .where((log) =>
            log.workoutExercise.exercise == widget.workoutExercise.exercise)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              onTap: onClicked,
              title: Text(
                widget.workoutExercise.exercise.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   widget.workoutExercise.exercise.description,
                  //   style: const TextStyle(fontSize: 14, color: Colors.grey),
                  // ),
                  const SizedBox(height: 5),
                  Text(
                    'Rest: ${widget.workoutExercise.restTimeSecond} sec',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              trailing: Icon(
                isOpened
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                size: 30,
              ),
            ),
            if (isOpened)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: logs.isNotEmpty
                    ? Column(
                        children: logs
                            .map((log) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child:
                                      WorkoutExerciseLogCard(workoutLog: log),
                                ))
                            .toList(),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 15),
                        child: Center(child: Text('No logs available')),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
