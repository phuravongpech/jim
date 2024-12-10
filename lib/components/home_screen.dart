import 'package:flutter/material.dart';

const color = Color(0xFF05b6ca);


class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: ListView(children: const [
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
        ]),
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Tuesday'), Text('Today')],
            ),
            ListTile(
              leading: Icon(
                Icons.circle_outlined,
                size: 40,
              ),
              title: Text(
                'workout leg #1.............',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('leg ..............'),
              trailing: Icon(Icons.nightlight_round_outlined),
            )
          ],
        ),
      ),
    );
  }
}
