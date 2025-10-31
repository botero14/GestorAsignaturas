import 'package:floor/floor.dart';
import '../../model/docente.dart';

@Entity(
  tableName: 'docentes',
  indices: [
    Index(value: ['correo'], unique: true),
  ],
)
class DocenteTable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String nombres;
  final String apellidos;
  final String correo;
  final String titulo;
  final String vinculacion;

  const DocenteTable({
    this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.titulo,
    required this.vinculacion,
  });

  Docente toModel() => Docente(
    id: id,
    nombres: nombres,
    apellidos: apellidos,
    correo: correo,
    titulo: titulo,
    vinculacion: vinculacion,
  );

  static DocenteTable fromModel(Docente d) => DocenteTable(
    id: d.id,
    nombres: d.nombres,
    apellidos: d.apellidos,
    correo: d.correo,
    titulo: d.titulo,
    vinculacion: d.vinculacion,
  );
}
