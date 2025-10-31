import '../../model/grupo_horario.dart';

abstract class GrupoHorarioRepository {
  Future<List<GrupoHorario>> byGrupo(int grupoId);
  Future<bool> hasOverlap({
    required int grupoId,
    required int diaSemana,
    required String inicio,
    required String fin,
    int? excludeId,
  });
  Future<int> add(GrupoHorario h);
  Future<int> update(GrupoHorario h);
  Future<void> remove(int id);
}
