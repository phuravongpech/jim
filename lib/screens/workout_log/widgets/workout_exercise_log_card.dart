import 'package:flutter/material.dart';
import '../../../models/workout_log.dart';
import '../../../utils/color_theme.dart';

class WorkoutExerciseLogCard extends StatelessWidget {
  final WorkoutLog workoutLog;

  const WorkoutExerciseLogCard({
    super.key,
    required this.workoutLog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              'SET ${workoutLog.setNumber}',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: subTextColor,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              '${workoutLog.rep} reps  x  ${workoutLog.weight} kg',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
