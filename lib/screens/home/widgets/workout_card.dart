import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jim/data/workout_data.dart';

import '../../../models/workout.dart';
import '../../../models/workout_log.dart';
import '../../workout/workout_screen.dart';
import '../../workout_log/workout_log_screen.dart';

class WorkoutCard extends StatefulWidget {
  final Workout workout;
  const WorkoutCard({
    super.key,
    required this.workout,
  });

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  bool isLogged = false;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM d, y').format(widget.workout.date);
    String day = DateFormat('EEEE').format(widget.workout.date);
    return GestureDetector(
      onTap: () async {
        final passedData = await Navigator.push<List<WorkoutLog>>(
            context,
            MaterialPageRoute(
                builder: (context) => isLogged
                    ? WorkoutLogScreen(currentWorkout: widget.workout)
                    : WorkoutScreen(
                        currentWorkout: widget.workout,
                      )));
        if (passedData != null) {
          print(passedData);
          setState(() {
            workoutLogs.addAll(passedData);
            isLogged = true;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(formattedDate), Text(day)],
              ),
              ListTile(
                leading: const Icon(
                  Icons.circle_outlined,
                  size: 40,
                ),
                title: Text(
                  widget.workout.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.workout.description),
                trailing: const Icon(Icons.nightlight_round_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
