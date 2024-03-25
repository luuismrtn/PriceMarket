class Producto {
  String nombre;
  List<double> precios;
  String categoria;
  List<String> cantidad;
  List<int> yuka;
  List<String> opinion;
  String imagen = '';
  DateTime fecha;

  List<String> url;

  Producto(
      {required this.nombre,
      required this.precios,
      required this.categoria,
      required this.cantidad,
      this.imagen = '',
      required this.yuka,
      required this.opinion,
      required this.fecha,
      required this.url});

  @override
  String toString() {
    return "$nombre, ${precios[0]}, ${precios[1]}, $categoria, ${cantidad[0]}, ${cantidad[1]}, ${yuka[0]}, ${yuka[1]}, ${opinion[0]}, ${opinion[1]}, $imagen, $fecha, ${url[0]}, ${url[1]}";
  }
}
