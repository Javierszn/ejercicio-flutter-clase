import 'package:flutter/material.dart';
import '../models/item.dart';
import 'detail_screen.dart';

class BacklogHomeScreen extends StatefulWidget {
  const BacklogHomeScreen({super.key});

  @override
  State<BacklogHomeScreen> createState() => _BacklogHomeScreenState();
}

class _BacklogHomeScreenState extends State<BacklogHomeScreen> {
  List<Item> miColeccion = [];
  final TextEditingController _tituloController = TextEditingController();

  //notificaciones
  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  //formulario
  void _mostrarDialogoAgregar() {
    //categorias
    final List<String> opcionesCategoria = ['PC', 'Consola', 'Móvil'];
    String categoriaSeleccionada = opcionesCategoria.first;
    _tituloController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Agregar nuevo elemento'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _tituloController,
                    decoration: const InputDecoration(labelText: 'Titulo del juego/libro'),
                  ),
                  const SizedBox(height: 20),
                  //menu de opciones
                  DropdownButton<String>(
                    value: categoriaSeleccionada,
                    isExpanded: true,
                    items: opcionesCategoria.map((String categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria,
                        child: Text(categoria),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      setStateDialog(() {
                        categoriaSeleccionada = nuevoValor!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_tituloController.text.isNotEmpty) {
                      setState(() {
                        miColeccion.add(
                          Item(
                            titulo: _tituloController.text,
                            categoria: categoriaSeleccionada,
                          ),
                        );
                      });
                      Navigator.pop(context);
                      _mostrarMensaje("Elemento agregado correctamente");
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backlog Tracker'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      // Interfaz dinamica
      body: miColeccion.isEmpty
          ? const Center(child: Text('Tu colecciin esta vacia. ¡Agrega algo!'))
          : ListView.builder(
              itemCount: miColeccion.length,
              itemBuilder: (context, index) {
                final item = miColeccion[index];

                //deslizar para borrar
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      miColeccion.removeAt(index);
                    });
                    _mostrarMensaje("Elemento eliminado correctamente");
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text(item.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(item.categoria),
                      trailing: Checkbox(
                        value: item.completado,
                        onChanged: (bool? valor) {
                          setState(() {
                            item.completado = valor ?? false;
                          });
                        },
                      ),
                      // pantalla de detalles
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(item: item),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      //Boton flotante
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAgregar,
        child: const Icon(Icons.add),
      ),
    );
  }
}