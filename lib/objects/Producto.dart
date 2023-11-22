class Producto {
  int id = 0;
  String nombre;
  List<double> precios;
  String categoria;
  List<String> cantidad;
  List<int> yuka;
  List<int> opinion;
  String imagen = '';
  DateTime fecha;

  Producto(
      {required this.id,
      required this.nombre,
      required this.precios,
      required this.categoria,
      required this.cantidad,
      this.imagen = '',
      required this.yuka,
      required this.opinion,
      required this.fecha});

  @override
  String toString() {
    return "$id, $nombre, ${precios[0]}, ${precios[1]}, $categoria, ${cantidad[0]}, ${cantidad[1]}, ${yuka[0]}, ${yuka[1]}, ${opinion[0]}, ${opinion[1]},$imagen, $fecha";
  }
}
