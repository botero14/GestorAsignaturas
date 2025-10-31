import 'package:floor/floor.dart';
import 'programa_table.dart';

@dao
abstract class ProgramaDao {
  @Query('SELECT * FROM programas ORDER BY nombre ASC')
  Future<List<ProgramaTable>> all();

  @Query('SELECT * FROM programas WHERE id = :id')
  Future<ProgramaTable?> byId(int id);

  @Query('SELECT COUNT(*) FROM programas WHERE codigo = :codigo')
  Future<int?> existsByCodigo(String codigo);

  @insert
  Future<int> insertOne(ProgramaTable row);

  @update
  Future<int> updateOne(ProgramaTable row);

  @Query('DELETE FROM programas WHERE id = :id')
  Future<void> deleteById(int id);
}
