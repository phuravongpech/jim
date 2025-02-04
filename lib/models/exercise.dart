import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 0)
class Exercise extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String gifUrl;

  @HiveField(3)
  final String bodyPart;

  @HiveField(4)
  final String equipment;

  @HiveField(5)
  final String target;

  @HiveField(6)
  final List<String>? instructions;

  @HiveField(7)
  final List<String>? secondaryMuscles;

  @HiveField(7)
  bool isFavorite;

  Exercise(
      {required this.id,
      required this.name,
      required this.gifUrl,
      required this.bodyPart,
      required this.equipment,
      required this.target,
      this.instructions,
      this.secondaryMuscles,
      this.isFavorite = false});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      gifUrl: json['gifUrl']?.toString() ?? '',
      bodyPart: json['bodyPart']?.toString() ?? '',
      equipment: json['equipment']?.toString() ?? '',
      target: json['target']?.toString() ?? '',
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Exercise{\n  name: $name,\n  url: $gifUrl,}';
  }
}
