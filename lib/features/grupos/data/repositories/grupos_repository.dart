import '../../model/grupo.dart';

abstract class GruposRepository {
  Future<List<Grupo>> all();
  Future<Grupo?> byId(int id);
  Future<List<Grupo>> byAsignatura(int asignaturaId);
  Future<List<Grupo>> byDocente(int docenteId);
  Future<int> add(Grupo g);
  Future<int> update(Grupo g);
  Future<void> remove(int id);
}
