import 'package:flutter/material.dart';
import 'package:jim/components/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logos/logo2.png'),
        backgroundColor: color,
        title: Text(
          'Cancel',
          style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
        ),
        actions: const [
          Icon(Icons.save_alt_sharp),
          SizedBox(
            width: 20,
          ),
          Text('Save'),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ListView(
        children: const [
          ExerciseCard(),
          ExerciseCard(),
          ExerciseCard(),
          SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({
    super.key,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool isOpened = false;

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
                subtitle: const Text('3 sets x 15 reps'),
                trailing: const Icon(
                  Icons.circle_outlined,
                  size: 40,
                ),
              ),
              if (isOpened)
                const Column(
                  children: [
                    ExerciseLogCard(),
                    ExerciseLogCard(),
                    ExerciseLogCard(),
                    ExerciseLogCard(),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseLogCard extends StatelessWidget {
  const ExerciseLogCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 1, // Set thickness of the line
          color: Colors.black.withOpacity(0.05), // Set color to a light shade
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              'SET 1',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 50,
              child: TextField(
                maxLength: 2,
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), counterText: ''),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'reps  x',
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black54),
            ),
            SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 70,
              child: TextField(
                maxLength: 4,
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), counterText: ''),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'kg',
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black54),
            ),
            Spacer(),
            Text('10 x 30 kg', style: TextStyle(color: Colors.black54))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(color: Colors.yellow[700]),
              child: const Icon(Icons.timer_outlined),
            ),
            const SizedBox(
              width: 20,
            ),
            const Text('Rest for 90s'),
            const Spacer(),
            TextButton.icon(
              style: const ButtonStyle(
                  iconSize: WidgetStatePropertyAll(26),
                  iconColor: WidgetStatePropertyAll(color)),
              onPressed: () {},
              label: const Text(
                'Start',
                style: TextStyle(fontSize: 16, color: color),
              ),
              icon: const Icon(Icons.access_time_rounded),
              iconAlignment: IconAlignment.start,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
