import 'package:flutter/material.dart';
import 'package:mi_primera_app/features/profile/screens/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State createState() => _MyHomePageState();
}
class _MyHomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text("Panel de actividad física"),
        
        // investigacion: Propiedad actions para alinear el boton a la derecha
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Ver Perfil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Resumen de hoy",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.directions_walk),
                title: Text("Pasos Diarios"),
                subtitle: Text("Meta: 10,000 pasos"),
                trailing: Text("7,450", style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 10), 
            const Card(
              child: ListTile(
                leading: Icon(Icons.fitness_center),
                title: Text("Press militar con mancuernas"),
                subtitle: Text("Hombros"),
                trailing: Text("4 series", style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 10),
            const Card(
              child: ListTile(
                leading: Icon(Icons.fitness_center),
                title: Text("Curl Bayesian"),
                subtitle: Text("Brazos"),
                trailing: Text("Pendiente", style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}