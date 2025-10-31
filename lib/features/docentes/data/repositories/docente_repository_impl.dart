import '../../model/docente.dart';
import '../../data/local/docente_table.dart';
import '../../data/local/docente_dao.dart';
import 'docente_repository.dart';

class DocenteRepositoryImpl implements DocenteRepository {
  final DocenteDao dao;
  DocenteRepositoryImpl(this.dao);

  @override
  Future<List<Docente>> all() async =>
      (await dao.all()).map((t) => t.toModel()).toList();

  @override
  Future<Docente?> byId(int id) async => (await dao.byId(id))?.toModel();

  @override
  Future<bool> existsCorreo(String correo) async =>
      (await dao.countByCorreo(correo)) != 0;

  @override
  Future<int> add(Docente d) => dao.insertOne(DocenteTable.fromModel(d));

  @override
  Future<int> update(Docente d) => dao.updateOne(DocenteTable.fromModel(d));

  @override
  Future<void> remove(int id) => dao.deleteById(id);
}
