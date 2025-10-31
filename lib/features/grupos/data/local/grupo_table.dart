import 'package:floor/floor.dart';
import '../../model/grupo.dart';
import '../../../asignaturas/data/local/asignatura_table.dart';
import '../../../docentes/data/local/docente_table.dart';

@Entity(
  tableName: 'grupos',
  foreignKeys: [
    ForeignKey(
      childColumns: ['asignaturaId'],
      parentColumns: ['id'],
      entity: AsignaturaTable,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['docenteId'],
      parentColumns: ['id'],
      entity: DocenteTable,
      onDelete: ForeignKeyAction.restrict, // o SET_NULL si creas migración
    ),
  ],
  indices: [
    Index(value: ['asignaturaId']),
    Index(value: ['docenteId']),
    Index(value: ['anio', 'periodo']),
  ],
)
class GrupoTable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int asignaturaId;
  final int? docenteId;
  final int capacidad;
  final int anio;
  final String periodo; // "01" | "02"

  const GrupoTable({
    this.id,
    required this.asignaturaId,
    this.docenteId,
    required this.capacidad,
    required this.anio,
    required this.periodo,
  });

  Grupo toModel() => Grupo(
    id: id,
    asignaturaId: asignaturaId,
    docenteId: docenteId,
    capacidad: capacidad,
    anio: anio,
    periodo: periodo,
  );

  static GrupoTable fromModel(Grupo g) => GrupoTable(
    id: g.id,
    asignaturaId: g.asignaturaId,
    docenteId: g.docenteId,
    capacidad: g.capacidad,
    anio: g.anio,
    periodo: g.periodo,
  );
}
