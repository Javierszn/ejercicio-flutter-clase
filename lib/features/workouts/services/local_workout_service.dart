import 'package:flutter/foundation.dart';
import '../models/workout_model.dart';
import '../../../core/database/database_helper.dart';

class LocalWorkoutService {
  final dbHelper = DatabaseHelper.instance;
  static final List<WorkoutModel> _webWorkouts = [];

  //Crear
  Future<int> insertWorkout(WorkoutModel workout) async {
    if (kIsWeb) {
      final id = _webWorkouts.isEmpty
          ? 1
          : (_webWorkouts.map((w) => w.localId ?? 0).reduce((a, b) => a > b ? a : b) + 1);
      final newW = WorkoutModel(
        localId: id,
        title: workout.title,
        category: workout.category,
        durationMinutes: workout.durationMinutes,
      );
      _webWorkouts.add(newW);
      return id;
    }
    final db = await dbHelper.database;
    final map = workout.toMap();
    if (workout.localId == null) {
      map.remove('id');
    }
    return await db.insert('workouts', map);
  }

  //Lectura
  Future<List<WorkoutModel>> getWorkouts() async {
    if (kIsWeb) {
      return List<WorkoutModel>.from(_webWorkouts);
    }
    final db = await dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query('workouts');

    return List.generate(maps.length, (i) {
      return WorkoutModel.fromMap(maps[i]);
    });
  }

  //Actualización
  Future<int> updateWorkout(WorkoutModel workout) async {
    if (kIsWeb) {
      final index = _webWorkouts.indexWhere((w) => w.localId == workout.localId);
      if (index != -1) {
        _webWorkouts[index] = workout;
        return 1;
      }
      return 0;
    }
    final db = await dbHelper.database;

    return await db.update(
      'workouts',
      workout.toMap(),
      where: 'id = ?',
      whereArgs: [workout.localId],
    );
  }

  //Eliminación
  Future<int> deleteWorkout(int id) async {
    if (kIsWeb) {
      _webWorkouts.removeWhere((w) => w.localId == id);
      return 1;
    }
    final db = await dbHelper.database;

    return await db.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
