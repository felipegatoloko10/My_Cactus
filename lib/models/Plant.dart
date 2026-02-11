class Plant {
  final int? id;
  final String name;
  final String species;
  final String imagePath;
  final int frequencyDays;
  final DateTime lastWateredDate;

  Plant({
    this.id,
    required this.name,
    required this.species,
    required this.imagePath,
    required this.frequencyDays,
    required this.lastWateredDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'imagePath': imagePath,
      'frequencyDays': frequencyDays,
      'lastWateredDate': lastWateredDate.toIso8601String(),
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'],
      name: map['name'],
      species: map['species'],
      imagePath: map['imagePath'],
      frequencyDays: map['frequencyDays'],
      lastWateredDate: DateTime.parse(map['lastWateredDate']),
    );
  }
}
