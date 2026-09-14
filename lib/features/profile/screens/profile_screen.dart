import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Perfil"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // investigacion: CircleAvatar para la imagen circular
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              "Javier Eduardo García Rivera",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // investigacion: Divider para la linea horizontal
            const Divider(
              thickness: 1.5,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            // investigacion: Row y MainAxisAlignment.spaceEvenly para centrar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: const [
                        Icon(Icons.calendar_month, color: Colors.blueAccent, size: 30),
                        SizedBox(height: 8),
                        Text("Rutina", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Arnold split\n5 días/sem", textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: const [
                        Icon(Icons.directions_walk, color: Colors.blueAccent, size: 30),
                        SizedBox(height: 8),
                        Text("Movimiento", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Meta diaria\n10,000 pasos", textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}