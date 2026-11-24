import 'package:flutter/material.dart';
import 'package:mi_primera_app/features/home/screens/add_workout_screen.dart';
import 'package:mi_primera_app/features/workouts/models/workout_model.dart';
import 'package:mi_primera_app/features/workouts/services/local_workout_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalWorkoutService _dbService = LocalWorkoutService();

  List<WorkoutModel> _workouts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    setState(() {
      _isLoading = true;
    });

    final workouts = await _dbService.getWorkouts();

    setState(() {
      _workouts = workouts;
      _isLoading = false;
    });
  }

  Future<void> _navigateToAddWorkout() async {
    final newWorkout = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddWorkoutScreen()),
    );

    if (newWorkout != null && newWorkout is WorkoutModel) {
      await _dbService.insertWorkout(newWorkout);
      _loadWorkouts();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rutina creada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _navegarYEditarRutina(WorkoutModel workout) async {
    final rutinaEditada = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddWorkoutScreen(workoutToEdit: workout),
      ),
    );

    if (rutinaEditada != null && rutinaEditada is WorkoutModel) {
      await _dbService.updateWorkout(rutinaEditada);
      if (mounted) {
        _loadWorkouts();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rutina actualizada')),
        );
      }
    }
  }

  Future<void> _deleteWorkout(int id, String title) async {
    await _dbService.deleteWorkout(id);

    if (mounted) {
      _loadWorkouts();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rutina eliminada: $title')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis entrenamientos"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _workouts.isEmpty
              ? const Center(child: Text('No tienes rutinas creadas'))
              : ListView.builder(
                  itemCount: _workouts.length,
                  itemBuilder: (context, index) {
                    final workout = _workouts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.fitness_center)),
                        title: Text(
                          workout.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${workout.category} - ${workout.durationMinutes} min',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _navegarYEditarRutina(workout),
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                            ),
                            IconButton(
                              onPressed: () =>
                                  _deleteWorkout(workout.localId!, workout.title),
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                        onTap: () => _navegarYEditarRutina(workout),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddWorkout,
        child: const Icon(Icons.add),
      ),
    );
  }
}
