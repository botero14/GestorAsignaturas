import 'package:floor/floor.dart';
import '../../model/grupo_horario.dart';
import 'grupo_table.dart';

@Entity(
  tableName: 'grupos_horarios',
  foreignKeys: [
    ForeignKey(
      childColumns: ['grupoId'],
      parentColumns: ['id'],
      entity: GrupoTable,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
  indices: [
    Index(value: ['grupoId']),
    // Evita duplicar exactamente el mismo tramo para el mismo grupo:
    Index(
      value: ['grupoId', 'diaSemana', 'horaInicio', 'horaFin'],
      unique: true,
    ),
  ],
)
class GrupoHorarioTable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int grupoId;
  final int diaSemana; // 1..7
  final String horaInicio; // "HH:MM"
  final String horaFin; // "HH:MM"

  const GrupoHorarioTable({
    this.id,
    required this.grupoId,
    required this.diaSemana,
    required this.horaInicio,
    required this.horaFin,
  });

  GrupoHorario toModel() => GrupoHorario(
    id: id,
    grupoId: grupoId,
    diaSemana: diaSemana,
    horaInicio: horaInicio,
    horaFin: horaFin,
  );

  static GrupoHorarioTable fromModel(GrupoHorario h) => GrupoHorarioTable(
    id: h.id,
    grupoId: h.grupoId,
    diaSemana: h.diaSemana,
    horaInicio: h.horaInicio,
    horaFin: h.horaFin,
  );
}
