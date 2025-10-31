import '../../model/estudiante.dart';
import '../local/estudiante_table.dart';
import '../local/estudiante_dao.dart';
import 'estudiante_repository.dart';

class EstudianteRepositoryImpl implements EstudianteRepository {
  final EstudianteDao dao;
  EstudianteRepositoryImpl(this.dao);

  @override
  Future<List<Estudiante>> all() async =>
      (await dao.all()).map((t) => t.toModel()).toList();

  @override
  Future<Estudiante?> byId(int id) async => (await dao.byId(id))?.toModel();

  @override
  Future<bool> existsCorreo(String correo) async =>
      (await dao.countByCorreo(correo)) != 0;

  @override
  Future<bool> existsCodigo(String codigo) async =>
      (await dao.countByCodigo(codigo)) != 0;

  @override
  Future<int> add(Estudiante e) => dao.insertOne(EstudianteTable.fromModel(e));

  @override
  Future<int> update(Estudiante e) =>
      dao.updateOne(EstudianteTable.fromModel(e));

  @override
  Future<void> remove(int id) => dao.deleteById(id);
}
