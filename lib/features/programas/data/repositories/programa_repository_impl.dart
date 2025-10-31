import '../../model/programa.dart';
import '../local/programa_table.dart';
import '../local/programa_dao.dart';
import 'programa_repository.dart';

class ProgramaRepositoryImpl implements ProgramaRepository {
  final ProgramaDao dao;
  ProgramaRepositoryImpl(this.dao);

  @override
  Future<List<Programa>> all() async =>
      (await dao.all()).map((t) => t.toModel()).toList();

  @override
  Future<Programa?> byId(int id) async => (await dao.byId(id))?.toModel();

  @override
  Future<bool> existsCodigo(String codigo) async =>
      (await dao.existsByCodigo(codigo)) != 0;

  @override
  Future<int> add(Programa p) => dao.insertOne(ProgramaTable.fromModel(p));

  @override
  Future<int> update(Programa p) => dao.updateOne(ProgramaTable.fromModel(p));

  @override
  Future<void> remove(int id) => dao.deleteById(id);
}
