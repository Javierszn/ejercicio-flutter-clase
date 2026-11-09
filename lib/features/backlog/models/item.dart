class Item {
  String titulo;
  String categoria;
  bool completado;

  Item({
    required this.titulo,
    required this.categoria,
    this.completado = false,
  });
}