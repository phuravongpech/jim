import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jim/screens/workout/widgets/countdown_timer.dart';
import 'package:logger/logger.dart';
import '../../../models/workout_exercise.dart';
import '../../../models/workout_log.dart';
import '../../../utils/color_theme.dart';

class ExerciseLogCard extends StatefulWidget {
  final WorkoutExercise workoutExercise;
  final int setNumber;

  const ExerciseLogCard({
    Key? key,
    required this.workoutExercise,
    required this.setNumber,
  }) : super(key: key);

  @override
  ExerciseLogCardState createState() => ExerciseLogCardState();
}

class ExerciseLogCardState extends State<ExerciseLogCard> {
  String _enteredReps = '';
  String _enteredWeight = '';

  final logger = Logger();

  WorkoutLog? get validateAndCreateLog {
    if (_enteredReps.isNotEmpty &&
        _enteredWeight.isNotEmpty &&
        int.tryParse(_enteredReps) != null &&
        double.tryParse(_enteredWeight) != null) {
      final workoutLog = WorkoutLog(
        workoutExercise: widget.workoutExercise,
        setNumber: widget.setNumber + 1,
        rep: int.parse(_enteredReps),
        weight: double.parse(_enteredWeight),
      );
      logger.d(workoutLog);
      return workoutLog;
    }
    return null;
  }

  String? validateRep(String? value) {
    if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'Rep range must be over number 0, Don\'t be lazy!';
    }
    logger.d(value);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 1,
          color: Colors.black.withOpacity(0.05),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              'SET ${widget.setNumber + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 50,
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 2,
                validator: validateRep,
                onChanged: (value) {
                  setState(() {
                    _enteredReps = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: '0',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'reps  x',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: subTextColor,
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 50,
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                maxLength: 5,
                onChanged: (value) {
                  setState(() {
                    _enteredWeight = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: '0',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'kg',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: subTextColor,
              ),
            ),
            const Spacer(),
            CountdownTimer(
              restTimeSecond: widget.workoutExercise.restTimeSecond,
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.timer_outlined, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Text('Rest for ${widget.workoutExercise.restTimeSecond}s'),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
