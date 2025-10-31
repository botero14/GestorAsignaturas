import 'package:flutter/foundation.dart';

// Interfaces (NO los *impl)
import '../../grupos/data/repositories/matricula_repository.dart';
import '../../grupos/data/repositories/grupos_repository.dart';
import '../../estudiantes/data/repositories/estudiante_repository.dart';
import '../../asignaturas/data/repositories/asignatura_repository.dart';
import '../../docentes/data/repositories/docente_repository.dart';

// Modelos
import '../model/matricula.dart';
import '../model/grupo.dart';
import '../../estudiantes/model/estudiante.dart';
import '../../asignaturas/model/asignatura.dart';
import '../../docentes/model/docente.dart';

class MatriculasVM extends ChangeNotifier {
  final MatriculaRepository repo;
  final GruposRepository gruposRepo;
  final EstudianteRepository estRepo;
  final AsignaturaRepository? asigRepo; // opcional
  final DocenteRepository? docRepo; // opcional

  MatriculasVM(
    this.repo,
    this.gruposRepo,
    this.estRepo, {
    this.asigRepo,
    this.docRepo,
  });

  int? grupoId;
  Grupo? grupo;
  Asignatura? asignatura;
  Docente? docente;

  List<Matricula> items = [];
  List<Estudiante> estudiantes = []; // todos
  List<Estudiante> noMatriculados = []; // para dropdown
  bool loading = false;
  String? lastError;

  Future<void> load(int gid) async {
    loading = true;
    lastError = null;
    notifyListeners();
    grupoId = gid;

    // Datos del grupo
    grupo = await gruposRepo.byId(gid);

    // ---- Asignatura (opcional): evitar orElse que devuelva null ----
    if (asigRepo != null && grupo != null) {
      final asigList = await asigRepo!.all();
      Asignatura? found;
      try {
        found = asigList.firstWhere((a) => a.id == grupo!.asignaturaId);
      } catch (_) {
        found = asigList.isNotEmpty ? asigList.first : null;
      }
      asignatura = found;
    }

    // ---- Docente (opcional): mismo patrón ----
    if (docRepo != null && grupo?.docenteId != null) {
      final docs = await docRepo!.all();
      Docente? foundDoc;
      try {
        foundDoc = docs.firstWhere((d) => d.id == grupo!.docenteId);
      } catch (_) {
        foundDoc = docs.isNotEmpty ? docs.first : null;
      }
      docente = foundDoc;
    }

    // Lista de matrículas + estudiantes
    items = await repo.byGrupo(gid);
    estudiantes = await estRepo.all();

    // Construye lista de candidatos (no matriculados)
    final setMat = items.map((m) => m.estudianteId).toSet();
    noMatriculados = estudiantes.where((e) => !setMat.contains(e.id)).toList();

    loading = false;
    notifyListeners();
  }

  Future<bool> add(int estudianteId) async {
    lastError = null;
    if (grupoId == null) return false;

    // Ya matriculado?
    if (await repo.exists(estudianteId, grupoId!)) {
      lastError = 'El estudiante ya está matriculado en este grupo';
      notifyListeners();
      return false;
    }

    // Cupo
    final ocupados = await repo.countInGrupo(grupoId!);
    final capacidad = grupo?.capacidad ?? 0;
    if (ocupados >= capacidad) {
      lastError = 'El grupo está lleno ($ocupados/$capacidad)';
      notifyListeners();
      return false;
    }

    final nowIso = DateTime.now().toIso8601String();
    await repo.add(
      Matricula(
        estudianteId: estudianteId,
        grupoId: grupoId!,
        fechaIso: nowIso,
      ),
    );
    await load(grupoId!);
    return true;
  }

  Future<void> remove(int estudianteId) async {
    if (grupoId == null) return;
    await repo.remove(estudianteId, grupoId!);
    await load(grupoId!);
  }

  String nombreEstudiante(int id) {
    final e = estudiantes.firstWhere(
      (x) => x.id == id,
      orElse: () => const Estudiante(
        id: -1,
        nombres: '—',
        apellidos: '',
        correo: '',
        codigoEstudiante: '',
      ),
    );
    if (e.id == -1) return '—';
    return '${e.nombres} ${e.apellidos}';
  }
}
