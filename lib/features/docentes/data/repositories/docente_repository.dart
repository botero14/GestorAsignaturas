import '../../model/docente.dart';

abstract class DocenteRepository {
  Future<List<Docente>> all();
  Future<Docente?> byId(int id);
  Future<bool> existsCorreo(String correo);
  Future<int> add(Docente d);
  Future<int> update(Docente d);
  Future<void> remove(int id);
}
