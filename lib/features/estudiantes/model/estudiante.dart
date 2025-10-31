class Estudiante {
  final int? id;
  final String nombres;
  final String apellidos;
  final String correo; // único
  final String codigoEstudiante; // único

  const Estudiante({
    this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.codigoEstudiante,
  });

  Estudiante copyWith({
    int? id,
    String? nombres,
    String? apellidos,
    String? correo,
    String? codigoEstudiante,
  }) => Estudiante(
    id: id ?? this.id,
    nombres: nombres ?? this.nombres,
    apellidos: apellidos ?? this.apellidos,
    correo: correo ?? this.correo,
    codigoEstudiante: codigoEstudiante ?? this.codigoEstudiante,
  );
}
