// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'package:jim/models/workout.dart';
// import 'package:jim/data/workout_data.dart';
// import 'package:flutter/services.dart';
// import 'package:logger/logger.dart';

// class WorkoutScreen extends StatefulWidget {
//   final Workout currentWorkout;

//   const WorkoutScreen({super.key, required this.currentWorkout});

//   @override
//   State<WorkoutScreen> createState() => _WorkoutScreenState();
// }

// class _WorkoutScreenState extends State<WorkoutScreen> {
//   late final list =
//       getExercisesFromWorkout(workoutExercises, widget.currentWorkout);
//   final List<WorkoutLog> logDataList = [];
//   final logger = Logger();

//   void _saveWorkout() {
//     // // Validate that logs are not empty before saving
//     // if (logDataList.isNotEmpty) {
//     //   Navigator.pop(context, logDataList);
//     // } else {
//     //   // Optional: Show a dialog or snackbar that no logs have been recorded
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     const SnackBar(
//     //         content: Text('Please log at least one set before saving')),
//     //   );
//     // }
//     logger.d(logDataList.map((e) => e.workoutExercise.exercise).toString());
//     Navigator.pop(context, logDataList);
//     // print(
//     //     'log data list = ${}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     logger.d(list.map((e) => e.exercise.name.toString()).toString());
//     return Scaffold(
//       appBar: AppBar(
//         leading: Image.asset('assets/logos/logo2.png', width: 40, height: 40),
//         backgroundColor: color,
//         title: TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         actions: [
//           Row(
//             children: [
//               const Icon(Icons.save_alt_sharp),
//               const SizedBox(width: 5),
//               GestureDetector(
//                 onTap: _saveWorkout,
//                 child: const Text('Save'),
//               ),
//               const SizedBox(width: 20),
//             ],
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: list.length,
//         itemBuilder: (context, index) => ExerciseCard(
//           currentWorkoutExercise: list[index],
//           addLog: (data) {
//             setState(() {
//               logDataList.addAll(data);
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

// class ExerciseCard extends StatefulWidget {
//   final WorkoutExercise currentWorkoutExercise;
//   final Function(List<WorkoutLog>) addLog;

//   const ExerciseCard({
//     super.key,
//     required this.currentWorkoutExercise,
//     required this.addLog,
//   });

//   @override
//   State<ExerciseCard> createState() => _ExerciseCardState();
// }

// class _ExerciseCardState extends State<ExerciseCard> {
//   bool isOpened = false;
//   List<WorkoutLog> currentExerciseLogs = [];

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
//               offset: const Offset(0, 3),
//             )
//           ],
//           border: Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               ListTile(
//                 onTap: onClicked,
//                 title: Text(
//                   widget.currentWorkoutExercise.exercise.name,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.currentWorkoutExercise.exercise.description),
//                     Text('${widget.currentWorkoutExercise.set} sets x 15 reps'),
//                   ],
//                 ),
//                 trailing: Icon(
//                   isOpened ? Icons.expand_less : Icons.circle_outlined,
//                   size: 40,
//                 ),
//               ),
//               if (isOpened)
//                 Column(
//                   children: [
//                     for (var i = 0; i < widget.currentWorkoutExercise.set; i++)
//                       ExerciseLogCard(
//                         workoutExercise: widget.currentWorkoutExercise,
//                         setNumber: i,
//                         onLogUpdated: (log) {
//                           currentExerciseLogs.add(log!);
//                           widget.addLog(currentExerciseLogs);
//                         },
//                       ),
//                   ],
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ExerciseLogCard extends StatefulWidget {
//   final WorkoutExercise workoutExercise;
//   final int setNumber;
//   final Function(WorkoutLog?) onLogUpdated;

//   const ExerciseLogCard(
//       {super.key,
//       required this.workoutExercise,
//       required this.setNumber,
//       required this.onLogUpdated});

//   @override
//   ExerciseLogCardState createState() => ExerciseLogCardState();
// }

// class ExerciseLogCardState extends State<ExerciseLogCard> {
//   final _formKey = GlobalKey<FormState>();
//   String _enteredReps = '';
//   String _enteredWeight = '';

//   late WorkoutLog currentLog;

//   WorkoutLog? getCurrentLog() {
//     bool isValid = _formKey.currentState!.validate();
//     if (isValid) {
//       _formKey.currentState!.save();
//       int reps = int.tryParse(_enteredReps) ?? 0;
//       double weight = double.tryParse(_enteredWeight) ?? 0;

//       return WorkoutLog(
//         workoutExercise: widget.workoutExercise,
//         setNumber: widget.setNumber + 1,
//         rep: reps,
//         weight: weight,
//       );
//     }
//     return null;
//   }

//   String? validateRep(String? value) {
//     if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
//       return 'Rep range must be over number 0, Dont be lazy! ';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Divider(
//           thickness: 1,
//           color: Colors.black.withOpacity(0.05),
//         ),
//         const SizedBox(height: 10),
//         Form(
//           key: _formKey,
//           onChanged: () {
//             widget.onLogUpdated(getCurrentLog());
//           },
//           child: Row(
//             children: [
//               Text(
//                 'SET ${widget.setNumber + 1}',
//                 style:
//                     const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(width: 20),
//               SizedBox(
//                 width: 50,
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   maxLength: 2,
//                   validator: validateRep,
//                   onSaved: (value) {
//                     _enteredReps = value!;
//                   },
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     counterText: '',
//                     hintText: '0',
//                   ),
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Text(
//                 'reps  x',
//                 style: TextStyle(
//                   fontWeight: FontWeight.normal,
//                   color: Colors.black54,
//                 ),
//               ),
//               const SizedBox(width: 20),
//               SizedBox(
//                 width: 50,
//                 child: TextFormField(
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   maxLength: 5,
//                   onSaved: (value) {
//                     _enteredWeight = value!;
//                   },
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     counterText: '',
//                     hintText: '0',
//                   ),
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Text(
//                 'kg',
//                 style: TextStyle(
//                   fontWeight: FontWeight.normal,
//                   color: Colors.black54,
//                 ),
//               ),
//               const Spacer(),
//               const Text('history set ...'),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             Container(
//               width: 50,
//               height: 40,
//               decoration: BoxDecoration(color: Colors.yellow[700]),
//               child: const Icon(Icons.timer_outlined),
//             ),
//             const SizedBox(width: 20),
//             Text('Rest for ${widget.workoutExercise.restTimeSecond}s'),
//             const Spacer(),
//             TextButton.icon(
//               style: const ButtonStyle(
//                 iconSize: WidgetStatePropertyAll(26),
//                 iconColor: WidgetStatePropertyAll(color),
//               ),
//               onPressed: () {
//                 // TODO: Implement rest timer functionality
//               },
//               label: const Text(
//                 'Start',
//                 style: TextStyle(fontSize: 16, color: color),
//               ),
//               icon: const Icon(Icons.access_time_rounded),
//               iconAlignment: IconAlignment.start,
//             )
//           ],
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
