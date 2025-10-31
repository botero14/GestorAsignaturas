import 'package:floor/floor.dart';
import 'grupo_horario_table.dart';

@dao
abstract class GrupoHorarioDao {
  @Query(
    'SELECT * FROM grupos_horarios WHERE grupoId = :grupoId ORDER BY diaSemana ASC, horaInicio ASC',
  )
  Future<List<GrupoHorarioTable>> byGrupo(int grupoId);

  @insert
  Future<int> insertOne(GrupoHorarioTable row);

  @update
  Future<int> updateOne(GrupoHorarioTable row);

  @Query('DELETE FROM grupos_horarios WHERE id = :id')
  Future<void> deleteById(int id);

  // <- aquí el fix:
  @Query('''
    SELECT COUNT(*) FROM grupos_horarios
    WHERE grupoId = :grupoId AND diaSemana = :diaSemana
      AND NOT (horaFin <= :inicio OR horaInicio >= :fin)
      AND (:excludeId = -1 OR id != :excludeId)
  ''')
  Future<int?> countOverlaps(
    int grupoId,
    int diaSemana,
    String inicio,
    String fin,
    int excludeId, // ¡NO NULLABLE!
  );
}
