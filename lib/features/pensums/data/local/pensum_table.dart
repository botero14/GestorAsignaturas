import 'package:floor/floor.dart';
import '../../model/pensum.dart';
import '../../../programas/data/local/programa_table.dart';

@Entity(
  tableName: 'pensums',
  foreignKeys: [
    ForeignKey(
      childColumns: ['programaId'],
      parentColumns: ['id'],
      entity: ProgramaTable,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
  indices: [
    Index(value: ['programaId']),
    Index(
      value: ['programaId', 'nombre'],
      unique: true,
    ), // evita duplicados por programa
  ],
)
class PensumTable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int programaId;
  final String nombre;
  final int anio;

  const PensumTable({
    this.id,
    required this.programaId,
    required this.nombre,
    required this.anio,
  });

  Pensum toModel() =>
      Pensum(id: id, programaId: programaId, nombre: nombre, anio: anio);

  static PensumTable fromModel(Pensum p) => PensumTable(
    id: p.id,
    programaId: p.programaId,
    nombre: p.nombre,
    anio: p.anio,
  );
}
