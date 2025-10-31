// lib/features/grupos/repositories/grupo_horario_repository_impl.dart
import '../../data/local/grupo_horario_dao.dart';
import '../../data/local/grupo_horario_table.dart';
import '../../model/grupo_horario.dart';
import 'grupo_horario_repository.dart';

class GrupoHorarioRepositoryImpl implements GrupoHorarioRepository {
  final GrupoHorarioDao dao;
  GrupoHorarioRepositoryImpl(this.dao);

  @override
  Future<List<GrupoHorario>> byGrupo(int grupoId) async =>
      (await dao.byGrupo(grupoId)).map((t) => t.toModel()).toList();

  @override
  Future<bool> hasOverlap({
    required int grupoId,
    required int diaSemana,
    required String inicio,
    required String fin,
    int? excludeId,
  }) async {
    final n = await dao.countOverlaps(
      grupoId,
      diaSemana,
      inicio,
      fin,
      excludeId ?? -1, // sentinela si no se excluye ningún id
    );
    return (n ?? 0) > 0;
  }

  @override
  Future<int> add(GrupoHorario h) =>
      dao.insertOne(GrupoHorarioTable.fromModel(h));

  @override
  Future<int> update(GrupoHorario h) =>
      dao.updateOne(GrupoHorarioTable.fromModel(h));

  @override
  Future<void> remove(int id) => dao.deleteById(id);
}
