class Grupo {
  final int? id;
  final int asignaturaId; // FK → Asignatura
  final int? docenteId; // FK → Docente (nullable si aún no asignado)
  final int capacidad;
  final int anio; // p.ej. 2026
  final String periodo; // "01" | "02"

  const Grupo({
    this.id,
    required this.asignaturaId,
    this.docenteId,
    required this.capacidad,
    required this.anio,
    required this.periodo,
  });

  Grupo copyWith({
    int? id,
    int? asignaturaId,
    int? docenteId,
    int? capacidad,
    int? anio,
    String? periodo,
  }) => Grupo(
    id: id ?? this.id,
    asignaturaId: asignaturaId ?? this.asignaturaId,
    docenteId: docenteId ?? this.docenteId,
    capacidad: capacidad ?? this.capacidad,
    anio: anio ?? this.anio,
    periodo: periodo ?? this.periodo,
  );
}
