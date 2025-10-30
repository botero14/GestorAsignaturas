import 'package:floor/floor.dart';
import '../../model/asignatura.dart';

@Entity(
  tableName: 'asignaturas',
  // Cuando implementemos Pensum, añadiremos la ForeignKey aquí.
  indices: [
    Index(value: ['pensumId']),
    Index(value: ['codigo'], unique: true),
  ],
)
class AsignaturaTable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int pensumId;
  final String nombre;
  final int creditos;
  final String area;
  final bool habilitable;
  final int semestre;
  final String codigo;
  final int horasSemana;

  const AsignaturaTable({
    this.id,
    required this.pensumId,
    required this.nombre,
    required this.creditos,
    required this.area,
    required this.habilitable,
    required this.semestre,
    required this.codigo,
    required this.horasSemana,
  });

  // Mappers
  Asignatura toModel() => Asignatura(
    id: id,
    pensumId: pensumId,
    nombre: nombre,
    creditos: creditos,
    area: area,
    habilitable: habilitable,
    semestre: semestre,
    codigo: codigo,
    horasSemana: horasSemana,
  );

  static AsignaturaTable fromModel(Asignatura a) => AsignaturaTable(
    id: a.id,
    pensumId: a.pensumId,
    nombre: a.nombre,
    creditos: a.creditos,
    area: a.area,
    habilitable: a.habilitable,
    semestre: a.semestre,
    codigo: a.codigo,
    horasSemana: a.horasSemana,
  );
}
