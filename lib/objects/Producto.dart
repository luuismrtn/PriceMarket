class Producto {
  int id = 0;
  String nombre;
  List<double> precios;
  String categoria;
  List<int> yuka;
  String imagen = '';
  DateTime fecha;

  Producto(
      {required this.id,
      required this.nombre,
      required this.precios,
      required this.categoria,
      this.imagen = '',
      required this.yuka,
      required this.fecha});

  @override
  String toString() {
    return "$id, $nombre, ${precios[0]}, ${precios[1]}, $categoria, ${yuka[0]}, ${yuka[1]}, $imagen, $fecha";
  }

  static Producto fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'] as int,
      nombre: map['nombre'] as String,
      precios: (map['precios'] as List<double>)
          .map((precio) => precio.toDouble())
          .toList(),
      categoria: map['categoria'] as String,
      yuka: (map['yuka'] as List<int>).map((yuka) => yuka.toInt()).toList(),
      imagen: map['imagen'] as String,
      fecha: DateTime.parse(map['fecha'] as String),
    );
  }
}
