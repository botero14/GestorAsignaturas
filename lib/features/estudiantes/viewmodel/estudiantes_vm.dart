import 'package:flutter/foundation.dart';
import '../model/estudiante.dart';
import '../data/repositories/estudiante_repository.dart';

class EstudiantesVM extends ChangeNotifier {
  final EstudianteRepository repo;
  EstudiantesVM(this.repo);

  List<Estudiante> items = [];
  bool loading = false;
  String? lastError;

  Future<void> load() async {
    loading = true;
    lastError = null;
    notifyListeners();
    items = await repo.all();
    loading = false;
    notifyListeners();
  }

  Future<bool> add(Estudiante e) async {
    lastError = null;
    if (await repo.existsCorreo(e.correo)) {
      lastError = 'El correo ya existe';
      notifyListeners();
      return false;
    }
    if (await repo.existsCodigo(e.codigoEstudiante)) {
      lastError = 'El código de estudiante ya existe';
      notifyListeners();
      return false;
    }
    await repo.add(e);
    await load();
    return true;
  }

  Future<void> update(Estudiante e) async {
    lastError = null;
    await repo.update(e);
    await load();
  }

  Future<void> remove(int id) async {
    await repo.remove(id);
    await load();
  }
}
