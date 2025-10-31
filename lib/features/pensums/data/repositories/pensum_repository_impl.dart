import '../../model/pensum.dart';
import '../../data/local/pensum_table.dart';
import '../../data/local/pensum_dao.dart';
import 'pensum_repository.dart';

class PensumRepositoryImpl implements PensumRepository {
  final PensumDao dao;
  PensumRepositoryImpl(this.dao);

  @override
  Future<List<Pensum>> all() async =>
      (await dao.all()).map((t) => t.toModel()).toList();

  @override
  Future<Pensum?> byId(int id) async => (await dao.byId(id))?.toModel();

  @override
  Future<List<Pensum>> byPrograma(int programaId) async =>
      (await dao.byPrograma(programaId)).map((t) => t.toModel()).toList();

  @override
  Future<bool> existsInPrograma(int programaId, String nombre) async =>
      (await dao.existsNombreInPrograma(programaId, nombre)) != 0;

  @override
  Future<int> add(Pensum p) => dao.insertOne(PensumTable.fromModel(p));

  @override
  Future<int> update(Pensum p) => dao.updateOne(PensumTable.fromModel(p));

  @override
  Future<void> remove(int id) => dao.deleteById(id);
}
