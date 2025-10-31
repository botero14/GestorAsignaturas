import 'package:floor/floor.dart';
import 'estudiante_table.dart';

@dao
abstract class EstudianteDao {
  @Query('SELECT * FROM estudiantes ORDER BY apellidos ASC, nombres ASC')
  Future<List<EstudianteTable>> all();

  @Query('SELECT * FROM estudiantes WHERE id = :id')
  Future<EstudianteTable?> byId(int id);

  @Query('SELECT COUNT(*) FROM estudiantes WHERE correo = :correo')
  Future<int?> countByCorreo(String correo);

  @Query('SELECT COUNT(*) FROM estudiantes WHERE codigoEstudiante = :codigo')
  Future<int?> countByCodigo(String codigo);

  @insert
  Future<int> insertOne(EstudianteTable row);

  @update
  Future<int> updateOne(EstudianteTable row);

  @Query('DELETE FROM estudiantes WHERE id = :id')
  Future<void> deleteById(int id);
}
