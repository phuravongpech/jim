import 'package:jim/utils/utils.dart';

enum Category { strength, powerlifting, cardio }

class Exercise {
  final String id; // Unique identifier for the exercise
  final String name;
  final String description;
  final Category category;

  Exercise({
    String? id, // Optional parameter
    required this.name,
    required this.description,
    required this.category,
  }) : id = id ?? Utils.generateUuid(); // Generate a new UUID if not provided

  @override
  String toString() {
    return 'Exercise{\n  name: $name,\n  description: $description,\n  category: $category\n}';
  }
}
