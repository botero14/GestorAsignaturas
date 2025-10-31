import 'package:flutter/foundation.dart';
import '../../grupos/model/grupo_horario.dart';
import '../../grupos/data/repositories/grupo_horario_repository.dart';

class GrupoHorarioVM extends ChangeNotifier {
  final GrupoHorarioRepository repo;
  GrupoHorarioVM(this.repo);

  List<GrupoHorario> items = [];
  bool loading = false;
  String? lastError;
  int? currentGrupoId;

  Future<void> load(int grupoId) async {
    loading = true;
    lastError = null;
    notifyListeners();
    currentGrupoId = grupoId;
    items = await repo.byGrupo(grupoId);
    loading = false;
    notifyListeners();
  }

  Future<bool> add(GrupoHorario h) async {
    lastError = null;
    // Validación básica: inicio < fin y sin solapes
    if (!_isRangeValid(h.horaInicio, h.horaFin)) {
      lastError = 'Rango de horas inválido';
      notifyListeners();
      return false;
    }
    if (await repo.hasOverlap(
      grupoId: h.grupoId,
      diaSemana: h.diaSemana,
      inicio: h.horaInicio,
      fin: h.horaFin,
      excludeId: null,
    )) {
      lastError = 'El tramo se solapa con otro existente';
      notifyListeners();
      return false;
    }
    await repo.add(h);
    await load(h.grupoId);
    return true;
  }

  Future<bool> update(GrupoHorario h) async {
    lastError = null;
    if (!_isRangeValid(h.horaInicio, h.horaFin)) {
      lastError = 'Rango de horas inválido';
      notifyListeners();
      return false;
    }
    if (await repo.hasOverlap(
      grupoId: h.grupoId,
      diaSemana: h.diaSemana,
      inicio: h.horaInicio,
      fin: h.horaFin,
      excludeId: h.id,
    )) {
      lastError = 'El tramo se solapa con otro existente';
      notifyListeners();
      return false;
    }
    await repo.update(h);
    await load(h.grupoId);
    return true;
  }

  Future<void> remove(int id) async {
    await repo.remove(id);
    if (currentGrupoId != null) {
      await load(currentGrupoId!);
    }
  }

  bool _isRangeValid(String ini, String fin) {
    int toMin(String hhmm) {
      final p = hhmm.split(':');
      if (p.length != 2) return -1;
      final h = int.tryParse(p[0]) ?? -1;
      final m = int.tryParse(p[1]) ?? -1;
      return (h < 0 || h > 23 || m < 0 || m > 59) ? -1 : (h * 60 + m);
    }

    final a = toMin(ini), b = toMin(fin);
    return a >= 0 && b >= 0 && a < b;
  }
}
