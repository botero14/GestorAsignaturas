import '../../model/grupo.dart';
import '../../data/local/grupo_table.dart';
import '../../data/local/grupo_dao.dart';
import 'grupos_repository.dart';

class GruposRepositoryImpl implements GruposRepository {
  final GrupoDao dao;
  GruposRepositoryImpl(this.dao);

  @override
  Future<List<Grupo>> all() async =>
      (await dao.all()).map((t) => t.toModel()).toList();

  @override
  Future<Grupo?> byId(int id) async => (await dao.byId(id))?.toModel();

  @override
  Future<List<Grupo>> byAsignatura(int asignaturaId) async =>
      (await dao.byAsignatura(asignaturaId)).map((t) => t.toModel()).toList();

  @override
  Future<List<Grupo>> byDocente(int docenteId) async =>
      (await dao.byDocente(docenteId)).map((t) => t.toModel()).toList();

  @override
  Future<int> add(Grupo g) => dao.insertOne(GrupoTable.fromModel(g));

  @override
  Future<int> update(Grupo g) => dao.updateOne(GrupoTable.fromModel(g));

  @override
  Future<void> remove(int id) => dao.deleteById(id);
}
