import 'package:flutter/material.dart';
import 'package:mi_primera_app/features/home/models/activity.dart';
class DetailScreen extends StatelessWidget {
  final Activity activity;

  const DetailScreen({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.activity.title)),
      body: Center(
        child: Column(
          children: 
          [
            Text('Detalles de la actividad'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}