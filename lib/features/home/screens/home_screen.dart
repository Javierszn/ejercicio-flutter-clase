import 'package:flutter/material.dart';
import 'package:mi_primera_app/features/home/widgets/step_counter_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 1. Creamos una lista dinámica que guarda el estado real de cada actividad
  List<Map<String, dynamic>> actividades = [
    {'titulo': 'Pasos Diarios', 'icono': Icons.directions_walk, 'color': Colors.blue, 'completada': false},
    {'titulo': 'Correr', 'icono': Icons.directions_run, 'color': Colors.blue, 'completada': true},
    {'titulo': 'Ciclismo', 'icono': Icons.directions_bike, 'color': Colors.blue, 'completada': false},
    {'titulo': 'Yoga', 'icono': Icons.self_improvement, 'color': Colors.blue, 'completada': true},
    {'titulo': 'Pilates', 'icono': Icons.accessibility_new, 'color': Colors.blue, 'completada': false},
    {'titulo': 'Entrenamiento HIIT', 'icono': Icons.fitness_center, 'color': Colors.blue, 'completada': true},
    {'titulo': 'Baile', 'icono': Icons.music_note, 'color': Colors.blue, 'completada': false},
    {'titulo': 'Senderismo', 'icono': Icons.terrain, 'color': Colors.blue, 'completada': true},
    {'titulo': 'Escalada', 'icono': Icons.terrain_outlined, 'color': Colors.blue, 'completada': false},
    {'titulo': 'Surf', 'icono': Icons.surfing, 'color': Colors.blue, 'completada': false},
    {'titulo': 'Kayak', 'icono': Icons.rowing, 'color': Colors.blue, 'completada': true},
    {'titulo': 'Rutina de Fuerza', 'icono': Icons.fitness_center, 'color': Colors.blue, 'completada': false},
    {'titulo': 'Natación', 'icono': Icons.pool, 'color': Colors.blue, 'completada': false},
    {'titulo': 'Box', 'icono': Icons.sports_mma, 'color': Colors.blue, 'completada': true},
    {'titulo': 'Calistenia', 'icono': Icons.sports_gymnastics, 'color': Colors.blue, 'completada': true},
    
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de actividad física'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: const [
          Icon(Icons.person),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const StepCounterCard(),
            const SizedBox(height: 10),
            // 2. Dibujamos la lista recorriendo nuestras variables dinámicas
            ...actividades.map((actividad) => _crearTarjetaInteractiva(actividad)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _crearTarjetaInteractiva(Map<String, dynamic> actividad) {
    bool completada = actividad['completada'];

    return Card(
      elevation: 2,
      color: completada ? Colors.green.shade100 : Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        // 3. Activamos la acción de tocar la tarjeta
        onTap: () {
          setState(() {
            // Invertimos el valor: si era false se vuelve true, y viceversa
            actividad['completada'] = !completada;
          });
        },
        leading: Icon(actividad['icono'], color: actividad['color'], size: 35),
        title: Text(
          actividad['titulo'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          completada ? 'Completada' : 'Pendiente de Completar',
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: Icon(
          completada ? Icons.check_circle : Icons.radio_button_unchecked,
          color: completada ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}