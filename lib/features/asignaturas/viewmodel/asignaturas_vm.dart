import 'package:flutter/foundation.dart';
import '../model/asignatura.dart';
import '../data/repositories/asignatura_repository.dart';

class AsignaturasVM extends ChangeNotifier {
  final AsignaturaRepository repo;
  AsignaturasVM(this.repo);

  List<Asignatura> items = [];
  bool loading = false;
  int? filtroPensumId; // opcional: para listar por pensum

  Future<void> load({int? pensumId}) async {
    loading = true;
    notifyListeners();
    filtroPensumId = pensumId;
    items = (pensumId == null)
        ? await repo.all()
        : await repo.byPensum(pensumId);
    loading = false;
    notifyListeners();
  }

  Future<void> add(Asignatura a) async {
    await repo.add(a);
    await load(pensumId: filtroPensumId);
  }

  Future<void> update(Asignatura a) async {
    await repo.update(a);
    await load(pensumId: filtroPensumId);
  }

  Future<void> remove(int id) async {
    await repo.remove(id);
    await load(pensumId: filtroPensumId);
  }
}
