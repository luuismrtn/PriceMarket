class Producto {
  int id = 0;
  String nombre;
  List<double> precios;
  String categoria;
  List<int> yuka;
  String imagen = '';

  Producto({required this.id, required this.nombre, required this.precios,
    required this.categoria, this.imagen = '', required this.yuka});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'mercadona': precios[0],
      'lidl': precios[1],
      'categoria': categoria,
      'yukaMercadona': yuka[0],
      'yukaLidl': yuka[1],
      'imagen': imagen,
    };
  }

  static Producto fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'] as int,
      nombre: map['nombre'] as String,
      precios: (map['precios'] as List<double>).map((precio) => precio.toDouble()).toList(),
      categoria: map['categoria'] as String,
      yuka: (map['yuka'] as List<int>).map((yuka) => yuka.toInt()).toList(),
      imagen: map['imagen'] as String,
    );
  }

}
