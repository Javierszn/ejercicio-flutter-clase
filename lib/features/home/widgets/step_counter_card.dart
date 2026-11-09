import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class StepCounterCard extends StatefulWidget {
  const StepCounterCard({super.key});

  @override
  State<StepCounterCard> createState() => _StepCounterCardState();
}

class _StepCounterCardState extends State<StepCounterCard> {
  late Stream<StepCount> _stepCountStream;
  String _pasos = '354';

  @override
  void initState() {
    super.initState();
   // _iniciarSensorPasos();
  }

  Future<void> _iniciarSensorPasos() async {
    // Pide permiso al usuario
    if (await Permission.activityRecognition.request().isGranted) {
      // Activa el sensor si hay permiso
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(_alActualizarPasos).onError(_alFallarSensor);
    } else {
      setState(() {
        _pasos = 'Permiso denegado';
      });
    }
    if (!mounted) return;
  }

  void _alActualizarPasos(StepCount event) {
    setState(() {
      _pasos = event.steps.toString();
    });
  }

  void _alFallarSensor(error) {
    setState(() {
      _pasos = '0'; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.blue.shade50, // Color azul claro del fondo
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_walk, size: 30, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Pasos de hoy',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              _pasos,
              style: const TextStyle(
                fontSize: 50, 
                fontWeight: FontWeight.bold, 
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}