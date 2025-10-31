import '../../data/local/matricula_dao.dart';
import '../../data/local/matricula_table.dart';
import '../../../grupos/model/matricula.dart';
import 'matricula_repository.dart';

class MatriculaRepositoryImpl implements MatriculaRepository {
  final MatriculaDao dao;
  MatriculaRepositoryImpl(this.dao);

  @override
  Future<List<Matricula>> byGrupo(int grupoId) async =>
      (await dao.byGrupo(grupoId)).map((t) => t.toModel()).toList();

  @override
  Future<List<Matricula>> byEstudiante(int estudianteId) async =>
      (await dao.byEstudiante(estudianteId)).map((t) => t.toModel()).toList();

  @override
  Future<int> countInGrupo(int grupoId) async =>
      (await dao.countInGrupo(grupoId)) ?? 0;

  @override
  Future<bool> exists(int estudianteId, int grupoId) async =>
      ((await dao.existsEnrollment(estudianteId, grupoId)) ?? 0) != 0;

  @override
  Future<void> add(Matricula m) => dao.insertOne(MatriculaTable.fromModel(m));

  @override
  Future<void> remove(int estudianteId, int grupoId) =>
      dao.deleteOne(estudianteId, grupoId);
}
