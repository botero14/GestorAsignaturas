import 'package:flutter/foundation.dart';
import '../model/programa.dart';
import '../data/repositories/programa_repository.dart';

class ProgramasVM extends ChangeNotifier {
  final ProgramaRepository repo;
  ProgramasVM(this.repo);

  List<Programa> items = [];
  bool loading = false;

  Future<void> load() async {
    loading = true;
    notifyListeners();
    items = await repo.all();
    loading = false;
    notifyListeners();
  }

  Future<String?> add(Programa p) async {
    // Validación simple de unicidad de código
    if (await repo.existsCodigo(p.codigo)) {
      return 'El código ya existe';
    }
    await repo.add(p);
    await load();
    return null;
  }

  Future<String?> update(Programa p) async {
    await repo.update(p);
    await load();
    return null;
  }

  Future<void> remove(int id) async {
    await repo.remove(id);
    await load();
  }
}
