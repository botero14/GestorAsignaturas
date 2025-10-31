// lib/features/grupos/viewmodel/grupos_vm.dart
import 'package:flutter/foundation.dart';

// Interfaces (NO los impl)
import '../../grupos/data/repositories/grupos_repository.dart';
import '../../asignaturas/data/repositories/asignatura_repository.dart';
import '../../docentes/data/repositories/docente_repository.dart';

// Modelos
import '../model/grupo.dart';
import '../../asignaturas/model/asignatura.dart';
import '../../docentes/model/docente.dart';

class GruposVM extends ChangeNotifier {
  final GruposRepository repo;
  final AsignaturaRepository asignaturaRepo;
  final DocenteRepository docenteRepo;

  GruposVM(this.repo, this.asignaturaRepo, this.docenteRepo);

  List<Grupo> items = [];
  bool loading = false;

  // Caches para nombres / dropdowns
  List<Asignatura> _asignaturas = [];
  List<Docente> _docentes = [];

  List<Asignatura> get asignaturas => _asignaturas;
  List<Docente> get docentes => _docentes;

  Future<void> load() async {
    loading = true; notifyListeners();
    items = await repo.all();
    _asignaturas = await asignaturaRepo.all();
    _docentes = await docenteRepo.all();
    loading = false; notifyListeners();
  }

  String nombreAsignatura(int id) {
    final a = _asignaturas.firstWhere(
      (x) => x.id == id,
      orElse: () => const Asignatura(
        id: -1, pensumId: 0, nombre: '—', creditos: 0, area: '',
        habilitable: true, semestre: 0, codigo: '', horasSemana: 0,
      ),
    );
    return a.nombre;
  }

  String nombreDocente(int? id) {
    if (id == null) return 'Sin docente';
    final d = _docentes.firstWhere(
      (x) => x.id == id,
      orElse: () => const Docente(
        id: -1, nombres: '—', apellidos: '', correo: '', titulo: '', vinculacion: '',
      ),
    );
    return d.id == -1 ? 'Sin docente' : '${d.nombres} ${d.apellidos}';
  }

  Future<void> add(Grupo g) async { await repo.add(g); await load(); }
  Future<void> update(Grupo g) async { await repo.update(g); await load(); }
  Future<void> remove(int id) async { await repo.remove(id); await load(); }
}
