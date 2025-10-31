class Programa {
  final int? id;
  final String nombre;
  final String codigo; // único

  const Programa({this.id, required this.nombre, required this.codigo});

  Programa copyWith({int? id, String? nombre, String? codigo}) => Programa(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    codigo: codigo ?? this.codigo,
  );
}
