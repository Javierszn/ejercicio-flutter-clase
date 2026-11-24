import 'package:flutter/material.dart';
import 'package:mi_primera_app/features/workouts/models/workout_model.dart';

class AddWorkoutScreen extends StatefulWidget {
  final WorkoutModel? workoutToEdit;

  const AddWorkoutScreen({super.key, this.workoutToEdit});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();

  String _selectedCategory = "Fuerza";
  final List<String> _categories = ['Fuerza', 'Cardio', 'Flexibilidad'];

  @override
  void initState() {
    super.initState();
    if (widget.workoutToEdit != null) {
      _titleController.text = widget.workoutToEdit!.title;
      _selectedCategory = widget.workoutToEdit!.category;
      _durationController.text = widget.workoutToEdit!.durationMinutes.toString();
    }
  }

  void _guardarRutina() {
    if (_formKey.currentState!.validate()) {
      final newWorkout = WorkoutModel(
        id: widget.workoutToEdit?.id,
        localId: widget.workoutToEdit?.localId,
        title: _titleController.text.trim(),
        category: _selectedCategory,
        durationMinutes: int.parse(_durationController.text.trim()),
      );

      Navigator.pop(context, newWorkout);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.workoutToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Rutina' : 'Crear Nueva Rutina'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  if (value.trim().length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.fitness_center),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duración (minutos)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timer),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa los minutos de duración';
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _guardarRutina,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isEditing ? 'Actualizar Rutina' : 'Guardar Rutina',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
