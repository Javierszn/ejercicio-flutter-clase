import 'package:flutter/material.dart';
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

  void _showAddWorkoutDialog() {
    final titleController = TextEditingController();
    final categoryController = TextEditingController();
    final durationMinutesController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nueva rutina'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Categoría"),
            ),
            TextField(
              controller: durationMinutesController,
              decoration: const InputDecoration(labelText: "Duración (minutos)"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  durationMinutesController.text.isNotEmpty &&
                  categoryController.text.isNotEmpty) {
                final newWorkout = WorkoutModel(
                  title: titleController.text.trim(),
                  category: categoryController.text.trim(),
                  durationMinutes:
                      int.tryParse(durationMinutesController.text.trim()) ?? 0,
                );

                await _dbService.insertWorkout(newWorkout);

                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
                _loadWorkouts();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showEditWorkoutDialog(WorkoutModel workout) {
    final titleController = TextEditingController(text: workout.title);
    final categoryController = TextEditingController(text: workout.category);
    final durationMinutesController =
        TextEditingController(text: workout.durationMinutes.toString());

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Editar rutina'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Categoría"),
            ),
            TextField(
              controller: durationMinutesController,
              decoration: const InputDecoration(labelText: "Duración (minutos)"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  durationMinutesController.text.isNotEmpty &&
                  categoryController.text.isNotEmpty) {
                final updatedWorkout = WorkoutModel(
                  localId: workout.localId,
                  title: titleController.text.trim(),
                  category: categoryController.text.trim(),
                  durationMinutes:
                      int.tryParse(durationMinutesController.text.trim()) ?? 0,
                );

                await _dbService.updateWorkout(updatedWorkout);

                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
                if (mounted) {
                  _loadWorkouts();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Rutina actualizada: ${updatedWorkout.title}'),
                    ),
                  );
                }
              }
            },
            child: const Text('Actualizar'),
          ),
        ],
      ),
    );
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
                              onPressed: () => _showEditWorkoutDialog(workout),
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                            ),
                            IconButton(
                              onPressed: () =>
                                  _deleteWorkout(workout.localId!, workout.title),
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                        onTap: () => _showEditWorkoutDialog(workout),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddWorkoutDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
