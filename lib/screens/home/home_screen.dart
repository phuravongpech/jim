import 'package:flutter/material.dart';

import 'package:jim/data/workout_data.dart';
import 'package:jim/screens/home/widgets/workout_card.dart';

const color = Color(0xFF05b6ca);

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        centerTitle: true,
        title: Image.asset(
          'assets/logos/logo1.png',
          width: 80,
        ),
        shadowColor: Colors.black,
      ),
      body: Center(
        child: Expanded(
          child: ListView.builder(
              itemCount: workouts.length, //workout list
              itemBuilder: (context, index) => WorkoutCard(
                    workout: workouts[index], //workout as parameter
                  )),
        ),
      ),
    );
  }
}
