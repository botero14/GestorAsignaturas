import 'package:floor/floor.dart';
import 'asignatura_table.dart';

@dao
abstract class AsignaturaDao {
  @Query('SELECT * FROM asignaturas ORDER BY semestre ASC, nombre ASC')
  Future<List<AsignaturaTable>> all();

  @Query('SELECT * FROM asignaturas WHERE id = :id')
  Future<AsignaturaTable?> byId(int id);

  @Query(
    'SELECT * FROM asignaturas WHERE pensumId = :pensumId ORDER BY semestre ASC, nombre ASC',
  )
  Future<List<AsignaturaTable>> byPensum(int pensumId);

  @insert
  Future<int> insertOne(AsignaturaTable row);

  @update
  Future<int> updateOne(AsignaturaTable row);

  @Query('DELETE FROM asignaturas WHERE id = :id')
  Future<void> deleteById(int id);
}
