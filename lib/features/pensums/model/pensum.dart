class Pensum {
  final int? id;
  final int programaId; // FK → Programa
  final String nombre; // etiqueta/versión (p.ej., "2026")
  final int anio;

  const Pensum({
    this.id,
    required this.programaId,
    required this.nombre,
    required this.anio,
  });

  Pensum copyWith({int? id, int? programaId, String? nombre, int? anio}) =>
      Pensum(
        id: id ?? this.id,
        programaId: programaId ?? this.programaId,
        nombre: nombre ?? this.nombre,
        anio: anio ?? this.anio,
      );
}
