import '../../model/pensum.dart';

abstract class PensumRepository {
  Future<List<Pensum>> all();
  Future<Pensum?> byId(int id);
  Future<List<Pensum>> byPrograma(int programaId);
  Future<bool> existsInPrograma(int programaId, String nombre);
  Future<int> add(Pensum p);
  Future<int> update(Pensum p);
  Future<void> remove(int id);
}
