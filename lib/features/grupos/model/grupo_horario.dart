class GrupoHorario {
  final int? id;
  final int grupoId; // FK → Grupo
  final int diaSemana; // 1=Lun .. 7=Dom
  final String horaInicio; // "HH:MM"
  final String horaFin; // "HH:MM"

  const GrupoHorario({
    this.id,
    required this.grupoId,
    required this.diaSemana,
    required this.horaInicio,
    required this.horaFin,
  });

  GrupoHorario copyWith({
    int? id,
    int? grupoId,
    int? diaSemana,
    String? horaInicio,
    String? horaFin,
  }) => GrupoHorario(
    id: id ?? this.id,
    grupoId: grupoId ?? this.grupoId,
    diaSemana: diaSemana ?? this.diaSemana,
    horaInicio: horaInicio ?? this.horaInicio,
    horaFin: horaFin ?? this.horaFin,
  );
}
