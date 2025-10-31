import 'package:floor/floor.dart';
import 'matricula_table.dart';

@dao
abstract class MatriculaDao {
  @Query(
    'SELECT * FROM matriculas WHERE grupoId = :grupoId ORDER BY fechaIso ASC',
  )
  Future<List<MatriculaTable>> byGrupo(int grupoId);

  @Query(
    'SELECT * FROM matriculas WHERE estudianteId = :estudianteId ORDER BY fechaIso DESC',
  )
  Future<List<MatriculaTable>> byEstudiante(int estudianteId);

  @Query('SELECT COUNT(*) FROM matriculas WHERE grupoId = :grupoId')
  Future<int?> countInGrupo(int grupoId);

  @Query(
    'SELECT COUNT(*) FROM matriculas WHERE estudianteId = :estudianteId AND grupoId = :grupoId',
  )
  Future<int?> existsEnrollment(int estudianteId, int grupoId);

  @insert
  Future<void> insertOne(MatriculaTable row);

  @Query(
    'DELETE FROM matriculas WHERE estudianteId = :estudianteId AND grupoId = :grupoId',
  )
  Future<void> deleteOne(int estudianteId, int grupoId);
}
