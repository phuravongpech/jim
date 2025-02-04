import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jim/models/exercise.dart';
import 'package:jim/screens/exercise/widgets/exercise_detail.dart';
import 'package:jim/services/cache_service.dart';

class ExerciseScreenCard extends StatefulWidget {
  const ExerciseScreenCard({
    super.key,
    required this.exercise, required this.onFavoriteReload,
  });

  final Exercise exercise;
  final VoidCallback onFavoriteReload;

  @override
  State<ExerciseScreenCard> createState() => _ExerciseScreenCardState();
}

class _ExerciseScreenCardState extends State<ExerciseScreenCard> {
  final cacheService = CacheService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetail(exercise: widget.exercise, onFavoriteReload: widget.onFavoriteReload,),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: 'exercise-${widget.exercise.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.exercise.gifUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: const Color(0xFFF5F7FA),
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF2D3142)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.exercise.name
                          .split(' ')
                          .map((word) =>
                              word[0].toUpperCase() + word.substring(1))
                          .join(' '),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.fitness_center,
                          size: 16,
                          color: Color(0xFF9BA3B2),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.exercise.equipment,
                          style: const TextStyle(
                            color: Color(0xFF9BA3B2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.track_changes,
                          size: 16,
                          color: Color(0xFF9BA3B2),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.exercise.target,
                          style: const TextStyle(
                            color: Color(0xFF9BA3B2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.fitness_center,
                          size: 16,
                          color: Color(0xFF9BA3B2),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Tooltip(
                            message:
                                widget.exercise.secondaryMuscles!.join(', '),
                            child: Text(
                              widget.exercise.secondaryMuscles!.join(', '),
                              style: const TextStyle(
                                color: Color(0xFF9BA3B2),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
