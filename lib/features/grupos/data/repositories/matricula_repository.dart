import '../../model/matricula.dart';

abstract class MatriculaRepository {
  Future<List<Matricula>> byGrupo(int grupoId);
  Future<List<Matricula>> byEstudiante(int estudianteId);
  Future<int> countInGrupo(int grupoId);
  Future<bool> exists(int estudianteId, int grupoId);
  Future<void> add(Matricula m);
  Future<void> remove(int estudianteId, int grupoId);
}
