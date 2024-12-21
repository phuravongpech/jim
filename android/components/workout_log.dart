// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'home_screen.dart';
// import 'package:jim/data/workout_data.dart';
// import 'package:jim/models/workout.dart';

// class WorkoutLogScreen extends StatelessWidget {
//   final Workout currentWorkout;
//   late final exerciseList =
//       getExercisesFromWorkout(workoutExercises, currentWorkout);
//   late final list = getWorkoutLogFromWorkoutExercise(workoutLogs, exerciseList);
//   WorkoutLogScreen({super.key, required this.currentWorkout});

//   @override
//   Widget build(BuildContext context) {
//     String formattedDate = DateFormat('MMMM d, y').format(currentWorkout.date);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: color,
//         centerTitle: true,
//         title: Image.asset(
//           'assets/logos/logo1.png',
//           width: 80,
//         ),
//         shadowColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                     // workoutLogs[1].workoutExercise.workout.id,
//                     list.first.workoutExercise.workout.name.toUpperCase(),
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 Text(
//                   formattedDate,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 ...exerciseList.map((exercise) => WorkoutExerciseCard(
//                       workoutExercise: exercise,
//                       workoutLogs: list,
//                     )),
//                 const SizedBox(
//                   height: 20,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WorkoutExerciseCard extends StatefulWidget {
//   final WorkoutExercise workoutExercise;
//   final List<WorkoutLog> workoutLogs;
//   const WorkoutExerciseCard({
//     super.key,
//     required this.workoutExercise,
//     required this.workoutLogs,
//   });

//   @override
//   State<WorkoutExerciseCard> createState() => _WorkoutExerciseCardState();
// }

// class _WorkoutExerciseCardState extends State<WorkoutExerciseCard> {
//   bool isOpened = true;

//   void onClicked() {
//     setState(() {
//       isOpened = !isOpened;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3), // changes position of shadow
//             )
//           ],
//           border: Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               ListTile(
//                   onTap: onClicked,
//                   // leading: Image.asset('assets/logos.logo1.png'),
//                   title: Text(
//                     widget.workoutExercise.exercise.name,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.workoutExercise.exercise.description,
//                       ),
//                       Text(
//                         '${widget.workoutExercise.restTimeSecond.toString()} seconds',
//                       ),
//                     ],
//                   ),
//                   trailing: isOpened
//                       ? const Icon(
//                           Icons.arrow_drop_down_outlined,
//                           size: 40,
//                         )
//                       : const Icon(
//                           Icons.arrow_drop_up_outlined,
//                           size: 40,
//                         )),
//               Divider(
//                 thickness: 1,
//                 color: Colors.black.withOpacity(0.1),
//               ),
//               if (isOpened)
//                 Column(
//                     children: widget.workoutLogs
//                         .where((e) =>
//                             widget.workoutExercise.exercise ==
//                             e.workoutExercise.exercise)
//                         .map((e) => WorkoutExerciseLogCard(workoutLog: e))
//                         .toList())
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WorkoutExerciseLogCard extends StatelessWidget {
//   final WorkoutLog workoutLog;
//   const WorkoutExerciseLogCard({
//     super.key,
//     required this.workoutLog,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       const SizedBox(
//         height: 10,
//       ),
//       Row(
//         children: [
//           Text(
//             'SET ${workoutLog.setNumber}',
//             style: const TextStyle(
//                 fontWeight: FontWeight.normal, color: Colors.black54),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Text('${workoutLog.rep} reps  x  ${workoutLog.weight} kg',
//               style:
//                   const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//         ],
//       ),
//     ]);
//   }
// }
