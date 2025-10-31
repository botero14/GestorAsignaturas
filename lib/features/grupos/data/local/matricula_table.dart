import 'package:floor/floor.dart';
import '../../model/matricula.dart';
import 'grupo_table.dart';
import '../../../estudiantes/data/local/estudiante_table.dart';

@Entity(
  tableName: 'matriculas',
  primaryKeys: ['estudianteId', 'grupoId'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['estudianteId'],
      parentColumns: ['id'],
      entity: EstudianteTable,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['grupoId'],
      parentColumns: ['id'],
      entity: GrupoTable,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
  indices: [
    Index(value: ['estudianteId']),
    Index(value: ['grupoId']),
  ],
)
class MatriculaTable {
  final int estudianteId;
  final int grupoId;
  final String fechaIso;

  const MatriculaTable({
    required this.estudianteId,
    required this.grupoId,
    required this.fechaIso,
  });

  Matricula toModel() => Matricula(
    estudianteId: estudianteId,
    grupoId: grupoId,
    fechaIso: fechaIso,
  );

  static MatriculaTable fromModel(Matricula m) => MatriculaTable(
    estudianteId: m.estudianteId,
    grupoId: m.grupoId,
    fechaIso: m.fechaIso,
  );
}
