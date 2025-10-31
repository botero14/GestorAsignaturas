import 'package:flutter/foundation.dart';
import '../model/docente.dart';
import '../data/repositories/docente_repository.dart';

class DocentesVM extends ChangeNotifier {
  final DocenteRepository repo;
  DocentesVM(this.repo);

  List<Docente> items = [];
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

  Future<bool> add(Docente d) async {
    lastError = null;
    if (await repo.existsCorreo(d.correo)) {
      lastError = 'El correo ya existe';
      notifyListeners();
      return false;
    }
    await repo.add(d);
    await load();
    return true;
  }

  Future<void> update(Docente d) async {
    lastError = null;
    await repo.update(d);
    await load();
  }

  Future<void> remove(int id) async {
    await repo.remove(id);
    await load();
  }
}
