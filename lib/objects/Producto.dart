class Producto {
  int id = 0;
  String nombre;
  List<double> precios;
  String categoria;

  Producto({required this.id, required this.nombre, required this.precios, required this.categoria});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio1': precios[0],
      'precio2': precios[1],
      'categoria': categoria,
    };
  }
}
