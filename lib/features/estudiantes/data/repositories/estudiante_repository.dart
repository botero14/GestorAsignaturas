import '../../model/estudiante.dart';

abstract class EstudianteRepository {
  Future<List<Estudiante>> all();
  Future<Estudiante?> byId(int id);
  Future<bool> existsCorreo(String correo);
  Future<bool> existsCodigo(String codigo);
  Future<int> add(Estudiante e);
  Future<int> update(Estudiante e);
  Future<void> remove(int id);
}
