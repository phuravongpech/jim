import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../models/workout_exercise.dart';
import '../../../models/workout_log.dart';
import 'exercise_log_card.dart';
import '../../../utils/color_theme.dart';

class ExerciseCard extends StatefulWidget {
  final WorkoutExercise currentWorkoutExercise;

  const ExerciseCard({
    super.key,
    required this.currentWorkoutExercise,
  });

  @override
  State<ExerciseCard> createState() => ExerciseCardState();
}

class ExerciseCardState extends State<ExerciseCard> {
  bool isOpened = true;
  List<WorkoutLog> currentExerciseLogs = [];
  final List<GlobalKey<ExerciseLogCardState>> logList = [];

  final logger = Logger();

  @override
  void initState() {
    super.initState();
    logList.addAll(List.generate(widget.currentWorkoutExercise.set,
        (index) => GlobalKey<ExerciseLogCardState>()));
  }

  List<WorkoutLog>? validateDataFromEachSet() {
    currentExerciseLogs.clear();
    for (var i = 0; i < widget.currentWorkoutExercise.set; i++) {
      final log = logList[i].currentState?.validateAndCreateLog;
      if (log != null) {
        currentExerciseLogs.add(log);
      }
    }
    return currentExerciseLogs.isNotEmpty ? currentExerciseLogs : null;
  }

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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: textColor,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   widget.currentWorkoutExercise.exercise.description ,
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //     color: subTextColor,
                    //   ),
                    // ),
                    Text(
                      '${widget.currentWorkoutExercise.set} sets x 15 reps',
                      style: const TextStyle(
                        fontSize: 16,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
                trailing: Icon(
                  isOpened ? Icons.expand_less : Icons.expand_more,
                  size: 30,
                  color: textColor,
                ),
              ),
              if (isOpened)
                Column(
                    children: List.generate(
                        widget.currentWorkoutExercise.set,
                        (index) => ExerciseLogCard(
                            key: logList[index],
                            workoutExercise: widget.currentWorkoutExercise,
                            setNumber: index)))
            ],
          ),
        ),
      ),
    );
  }
}
