class WorkoutModel {
  final int? localId;
  final String title;
  final String category;
  final int durationMinutes;

  int? get id => localId;

  WorkoutModel({
    int? localId,
    int? id,
    required this.title,
    required this.category,
    required this.durationMinutes,
  }) : localId = localId ?? id;

  Map<String, dynamic> toMap() {
    return {
      'id': localId,
      'title': title,
      'category': category,
      'duration_minutes': durationMinutes,
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      localId: map['id'],
      title: map['title'],
      category: map['category'],
      durationMinutes: map['duration_minutes'],
    );
  }
}
