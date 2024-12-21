
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/workout_exercise.dart';
import '../../../models/workout_log.dart';

class ExerciseLogCard extends StatefulWidget {
  final WorkoutExercise workoutExercise;
  final int setNumber;
  final Function(WorkoutLog?) onLogUpdated;

  const ExerciseLogCard(
      {super.key,
      required this.workoutExercise,
      required this.setNumber,
      required this.onLogUpdated});

  @override
  ExerciseLogCardState createState() => ExerciseLogCardState();
}

class ExerciseLogCardState extends State<ExerciseLogCard> {
  final _formKey = GlobalKey<FormState>();
  String _enteredReps = '';
  String _enteredWeight = '';

  late WorkoutLog currentLog;

  WorkoutLog? getCurrentLog() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      int reps = int.tryParse(_enteredReps) ?? 0;
      double weight = double.tryParse(_enteredWeight) ?? 0;

      return WorkoutLog(
        workoutExercise: widget.workoutExercise,
        setNumber: widget.setNumber + 1,
        rep: reps,
        weight: weight,
      );
    }
    return null;
  }

  String? validateRep(String? value) {
    if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'Rep range must be over number 0, Dont be lazy! ';
    }
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
        Form(
          key: _formKey,
          onChanged: () {
            widget.onLogUpdated(getCurrentLog());
          },
          child: Row(
            children: [
              Text(
                'SET ${widget.setNumber + 1}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 50,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  validator: validateRep,
                  onSaved: (value) {
                    _enteredReps = value!;
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
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 50,
                child: TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  maxLength: 5,
                  onSaved: (value) {
                    _enteredWeight = value!;
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
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              const Text('history set ...'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(color: Colors.yellow[700]),
              child: const Icon(Icons.timer_outlined),
            ),
            const SizedBox(width: 20),
            Text('Rest for ${widget.workoutExercise.restTimeSecond}s'),
            const Spacer(),
            TextButton.icon(
              style: const ButtonStyle(
                iconSize: WidgetStatePropertyAll(26),
                // iconColor: WidgetStatePropertyAll(color),
              ),
              onPressed: () {
                // TODO: Implement rest timer functionality
              },
              label: const Text(
                'Start',
                // style: TextStyle(fontSize: 16, color: color),
              ),
              icon: const Icon(Icons.access_time_rounded),
              iconAlignment: IconAlignment.start,
            )
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
