import '../../model/programa.dart';

abstract class ProgramaRepository {
  Future<List<Programa>> all();
  Future<Programa?> byId(int id);
  Future<bool> existsCodigo(String codigo);
  Future<int> add(Programa p);
  Future<int> update(Programa p);
  Future<void> remove(int id);
}
