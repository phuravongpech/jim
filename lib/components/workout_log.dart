import 'package:flutter/material.dart';

class WorkoutLogScreen extends StatelessWidget {
  const WorkoutLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Workout ID #69',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Text(
                'Date 12/12/2024',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView(
            children: const [
              WorkoutExerciseCard(),
              WorkoutExerciseCard(),
              WorkoutExerciseCard(),
              WorkoutExerciseCard(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class WorkoutExerciseCard extends StatefulWidget {
  const WorkoutExerciseCard({
    super.key,
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
                  title: const Text(
                    'Exercise #1.............',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3 sets x 15 reps',
                      ),
                      Text(
                        'Rest time 90s',
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
                const Column(
                  children: [
                    WorkoutExerciseLogCard(),
                    WorkoutExerciseLogCard(),
                    WorkoutExerciseLogCard(),
                    WorkoutExerciseLogCard(),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutExerciseLogCard extends StatelessWidget {
  const WorkoutExerciseLogCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Text(
            'SET 1',
            style:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
          ),
          SizedBox(
            width: 10,
          ),
          Text('15 reps  x  30 kg',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    ]);
  }
}
