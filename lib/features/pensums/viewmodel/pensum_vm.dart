import 'package:flutter/foundation.dart';
import '../model/pensum.dart';
import '../data/repositories/pensum_repository.dart';

class PensumsVM extends ChangeNotifier {
  final PensumRepository repo;
  PensumsVM(this.repo);

  List<Pensum> items = [];
  bool loading = false;
  int? filtroProgramaId;

  Future<void> load({int? programaId}) async {
    loading = true;
    notifyListeners();
    filtroProgramaId = programaId;
    items = (programaId == null)
        ? await repo.all()
        : await repo.byPrograma(programaId);
    loading = false;
    notifyListeners();
  }

  Future<String?> add(Pensum p) async {
    if (await repo.existsInPrograma(p.programaId, p.nombre)) {
      return 'Ya existe un pensum con ese nombre en el programa';
    }
    await repo.add(p);
    await load(programaId: filtroProgramaId);
    return null;
  }

  Future<void> update(Pensum p) async {
    await repo.update(p);
    await load(programaId: filtroProgramaId);
  }

  Future<void> remove(int id) async {
    await repo.remove(id);
    await load(programaId: filtroProgramaId);
  }
}
