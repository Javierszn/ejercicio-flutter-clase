class WorkoutModel {
  final int? localId;
  //final int? apiId;
  final String title;
  final String category;
  final int durationMinutes;

  WorkoutModel({
    this.localId,
    //this.apiId,
    required this.title,
    required this.category,
    required this.durationMinutes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': localId,
      //'api_id': apiId,
      'title': title,
      'category': category,
      'duration_minutes': durationMinutes,
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      localId: map['id'],
      //apiId: map['api_id'],
      title: map['title'],
      category: map['category'],
      durationMinutes: map['duration_minutes'],
    );
  }
}
