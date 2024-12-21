
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
              offset: const Offset(0, 3), // changes position of shadow
            )
          ],
          border: Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                  onTap: onClicked,
                  // leading: Image.asset('assets/logos.logo1.png'),
                  title: Text(
                    widget.workoutExercise.exercise.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.workoutExercise.exercise.description,
                      ),
                      Text(
                        '${widget.workoutExercise.restTimeSecond.toString()} seconds',
                      ),
                    ],
                  ),
                  trailing: isOpened
                      ? const Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 40,
                        )
                      : const Icon(
                          Icons.arrow_drop_up_outlined,
                          size: 40,
                        )),
              Divider(
                thickness: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              if (isOpened)
                Column(
                    children: widget.workoutLogs
                        .where((e) =>
                            widget.workoutExercise.exercise ==
                            e.workoutExercise.exercise)
                        .map((e) => WorkoutExerciseLogCard(workoutLog: e))
                        .toList()
                        .cast<Widget>())
            ],
          ),
        ),
      ),
    );
  }
}
