class Docente {
  final int? id;
  final String nombres;
  final String apellidos;
  final String correo; // único
  final String titulo; // ej: "M.Sc.", "Ph.D."
  final String vinculacion; // "Catedratico" | "Ocasional" | "Planta"

  const Docente({
    this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.titulo,
    required this.vinculacion,
  });

  Docente copyWith({
    int? id,
    String? nombres,
    String? apellidos,
    String? correo,
    String? titulo,
    String? vinculacion,
  }) => Docente(
    id: id ?? this.id,
    nombres: nombres ?? this.nombres,
    apellidos: apellidos ?? this.apellidos,
    correo: correo ?? this.correo,
    titulo: titulo ?? this.titulo,
    vinculacion: vinculacion ?? this.vinculacion,
  );
}
