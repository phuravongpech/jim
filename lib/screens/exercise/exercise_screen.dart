import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jim/models/exercise.dart';
import 'package:jim/services/exercise_service.dart';
import 'package:jim/utils/color_theme.dart';
import 'package:logger/logger.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final log = Logger();

  final ExerciseService exerciseService = ExerciseService();
  List<Exercise> _exercises = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadExercises();
  }

  Future<void> loadExercises() async {
    try {
      setState(() {
        //first its loading
        isLoading = true;
        error = null;
      });
      log.d('fetching...');
      final exercises = await exerciseService.getExercises();
      log.d('fetching done ');
      setState(() {
        _exercises = exercises;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        log.d('error : $e');
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // Flat design
          centerTitle: true,
          title: const Text(
            'Exercise List',
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error'),
            ElevatedButton(
              onPressed: loadExercises,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: loadExercises,
      child: ListView.builder(
        itemCount: _exercises.length,
        itemBuilder: (context, index) {
          final exercise = _exercises[index];
          return Card(
            color: secondaryColor,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: exercise.gifUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              title: Text(exercise.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Target: ${exercise.target}'),
                  Text('Equipment: ${exercise.equipment}'),
                ],
              ),
              onTap: () {
                // Navigate to exercise details screen
              },
            ),
          );
        },
      ),
    );
  }
}
