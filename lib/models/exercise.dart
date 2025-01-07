class Exercise {
  final String id; // Unique identifier for the exercise
  final String name;
  final String gifUrl;
  final String bodyPart;
  final String target;
  final String equipment;
  final List<String>? instructions;

  Exercise(
      {required this.id,
      required this.name,
      required this.gifUrl,
      required this.bodyPart,
      required this.target,
      required this.equipment,
      this.instructions});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        gifUrl: json['gifUrl']?.toString() ?? '',
        bodyPart: json['bodyPart']?.toString() ?? '',
        equipment: json['equipment']?.toString() ?? '',
        target: json['target']?.toString() ?? ''
        );
  }

  @override
  String toString() {
    return 'Exercise{\n  name: $name,\n  url: $gifUrl,}';
  }
}
