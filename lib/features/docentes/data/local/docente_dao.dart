import 'package:floor/floor.dart';
import 'docente_table.dart';

@dao
abstract class DocenteDao {
  @Query('SELECT * FROM docentes ORDER BY apellidos ASC, nombres ASC')
  Future<List<DocenteTable>> all();

  @Query('SELECT * FROM docentes WHERE id = :id')
  Future<DocenteTable?> byId(int id);

  @Query('SELECT COUNT(*) FROM docentes WHERE correo = :correo')
  Future<int?> countByCorreo(String correo);

  @insert
  Future<int> insertOne(DocenteTable row);

  @update
  Future<int> updateOne(DocenteTable row);

  @Query('DELETE FROM docentes WHERE id = :id')
  Future<void> deleteById(int id);
}
