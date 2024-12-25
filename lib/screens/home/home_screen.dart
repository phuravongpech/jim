import 'package:flutter/material.dart';

import 'package:jim/data/workout_data.dart';
import 'package:jim/screens/home/widgets/workout_card.dart';
import 'package:jim/utils/color_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Image.asset(
          'assets/logos/logo1.png',
          width: 80,
        ),
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) => WorkoutCard(
            workout: workouts[index],
          ),
        ),
      ),
    );
  }
}
