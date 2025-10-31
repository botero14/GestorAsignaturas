class Matricula {
  final int estudianteId; // PK (compuesto)
  final int grupoId; // PK (compuesto)
  final String fechaIso; // ISO8601 (ej.: "2025-10-31T09:00:00Z")

  const Matricula({
    required this.estudianteId,
    required this.grupoId,
    required this.fechaIso,
  });

  Matricula copyWith({int? estudianteId, int? grupoId, String? fechaIso}) =>
      Matricula(
        estudianteId: estudianteId ?? this.estudianteId,
        grupoId: grupoId ?? this.grupoId,
        fechaIso: fechaIso ?? this.fechaIso,
      );
}
