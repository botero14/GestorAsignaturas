import 'package:floor/floor.dart';
import 'pensum_table.dart';

@dao
abstract class PensumDao {
  @Query('SELECT * FROM pensums ORDER BY anio DESC, nombre ASC')
  Future<List<PensumTable>> all();

  @Query('SELECT * FROM pensums WHERE id = :id')
  Future<PensumTable?> byId(int id);

  @Query(
    'SELECT * FROM pensums WHERE programaId = :programaId ORDER BY anio DESC, nombre ASC',
  )
  Future<List<PensumTable>> byPrograma(int programaId);

  @Query(
    'SELECT COUNT(*) FROM pensums WHERE programaId = :programaId AND nombre = :nombre',
  )
  Future<int?> existsNombreInPrograma(int programaId, String nombre);

  @insert
  Future<int> insertOne(PensumTable row);

  @update
  Future<int> updateOne(PensumTable row);

  @Query('DELETE FROM pensums WHERE id = :id')
  Future<void> deleteById(int id);
}
