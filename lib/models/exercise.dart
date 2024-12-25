import 'package:jim/utils/utils.dart';

class Exercise {
  final String id; // Unique identifier for the exercise
  final String name;
  final String description;

  Exercise({
    String? id, // Optional parameter
    required this.name,
    required this.description,
  }) : id = id ?? Utils.generateUuid(); // Generate a new UUID if not provided

  @override
  String toString() {
    return 'Exercise{\n  name: $name,\n  description: $description,}';
  }
}
