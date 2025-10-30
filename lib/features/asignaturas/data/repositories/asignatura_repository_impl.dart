import '../../model/asignatura.dart';
import '../../data/local/asignatura_dao.dart';
import '../../data/local/asignatura_table.dart';
import 'asignatura_repository.dart';

class AsignaturaRepositoryImpl implements AsignaturaRepository {
  final AsignaturaDao dao;
  AsignaturaRepositoryImpl(this.dao);

  @override
  Future<List<Asignatura>> all() async =>
      (await dao.all()).map((t) => t.toModel()).toList();

  @override
  Future<List<Asignatura>> byPensum(int pensumId) async =>
      (await dao.byPensum(pensumId)).map((t) => t.toModel()).toList();

  @override
  Future<int> add(Asignatura a) => dao.insertOne(AsignaturaTable.fromModel(a));

  @override
  Future<int> update(Asignatura a) =>
      dao.updateOne(AsignaturaTable.fromModel(a));

  @override
  Future<void> remove(int id) => dao.deleteById(id);
}
