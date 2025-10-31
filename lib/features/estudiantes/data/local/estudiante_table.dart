import 'package:floor/floor.dart';
import '../../model/estudiante.dart';

@Entity(
  tableName: 'estudiantes',
  indices: [
    Index(value: ['correo'], unique: true),
    Index(value: ['codigoEstudiante'], unique: true),
  ],
)
class EstudianteTable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String nombres;
  final String apellidos;
  final String correo;
  final String codigoEstudiante;

  const EstudianteTable({
    this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.codigoEstudiante,
  });

  Estudiante toModel() => Estudiante(
        id: id,
        nombres: nombres,
        apellidos: apellidos,
        correo: correo,
        codigoEstudiante: codigoEstudiante,
      );

  static EstudianteTable fromModel(Estudiante e) => EstudianteTable(
        id: e.id,
        nombres: e.nombres,
        apellidos: e.apellidos,
        correo: e.correo,
        codigoEstudiante: e.codigoEstudiante,
      );
}
