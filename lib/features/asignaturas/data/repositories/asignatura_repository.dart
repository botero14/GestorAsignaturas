import '../../model/asignatura.dart';

abstract class AsignaturaRepository {
  Future<List<Asignatura>> all();
  Future<List<Asignatura>> byPensum(int pensumId);
  Future<int> add(Asignatura a);
  Future<int> update(Asignatura a);
  Future<void> remove(int id);
}
