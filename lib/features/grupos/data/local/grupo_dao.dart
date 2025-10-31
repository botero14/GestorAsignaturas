import 'package:floor/floor.dart';
import 'grupo_table.dart';

@dao
abstract class GrupoDao {
  @Query('SELECT * FROM grupos ORDER BY anio DESC, periodo DESC, id DESC')
  Future<List<GrupoTable>> all();

  @Query('SELECT * FROM grupos WHERE id = :id')
  Future<GrupoTable?> byId(int id);

  @Query(
    'SELECT * FROM grupos WHERE asignaturaId = :asignaturaId ORDER BY anio DESC, periodo DESC',
  )
  Future<List<GrupoTable>> byAsignatura(int asignaturaId);

  @Query(
    'SELECT * FROM grupos WHERE docenteId = :docenteId ORDER BY anio DESC, periodo DESC',
  )
  Future<List<GrupoTable>> byDocente(int docenteId);

  @insert
  Future<int> insertOne(GrupoTable row);

  @update
  Future<int> updateOne(GrupoTable row);

  @Query('DELETE FROM grupos WHERE id = :id')
  Future<void> deleteById(int id);
}
