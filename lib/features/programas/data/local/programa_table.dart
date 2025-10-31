import 'package:floor/floor.dart';
import '../../model/programa.dart';

@Entity(
  tableName: 'programas',
  indices: [
    Index(value: ['codigo'], unique: true),
  ],
)
class ProgramaTable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String nombre;
  final String codigo;

  const ProgramaTable({this.id, required this.nombre, required this.codigo});

  Programa toModel() => Programa(id: id, nombre: nombre, codigo: codigo);

  static ProgramaTable fromModel(Programa p) =>
      ProgramaTable(id: p.id, nombre: p.nombre, codigo: p.codigo);
}
