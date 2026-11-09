import 'package:flutter/material.dart';
import '../models/item.dart';

class DetailScreen extends StatelessWidget {
  final Item item;
  const DetailScreen({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Item'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título: ${item.titulo}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Categoría: ${item.categoria}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              item.completado ? 'Estado: Completado' : 'Estado: Pendiente',
              style: TextStyle(
                fontSize: 18, 
                color: item.completado ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}