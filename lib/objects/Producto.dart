class Producto {
  int id = 0;
  String nombre;
  List<double> precios;
  String categoria;
  String imagen = '';

  Producto({required this.id, required this.nombre, required this.precios, required this.categoria, this.imagen = ''});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'mercadona': precios[0],
      'lidl': precios[1],
      'categoria': categoria,
      'imagen': imagen,
    };
  }
}
