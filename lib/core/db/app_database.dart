// lib/core/db/app_database.dart
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

// ====== IMPORTS DE TODAS LAS TABLAS/DAOS ======
// Programas
import '../../features/programas/data/local/programa_table.dart';
import '../../features/programas/data/local/programa_dao.dart';

// Pensums
import '../../features/pensums/data/local/pensum_table.dart';
import '../../features/pensums/data/local/pensum_dao.dart';

// Asignaturas
import '../../features/asignaturas/data/local/asignatura_table.dart';
import '../../features/asignaturas/data/local/asignatura_dao.dart';

// Estudiantes
import '../../features/estudiantes/data/local/estudiante_table.dart';
import '../../features/estudiantes/data/local/estudiante_dao.dart';

// Docentes
import '../../features/docentes/data/local/docente_table.dart';
import '../../features/docentes/data/local/docente_dao.dart';

// Grupos
import '../../features/grupos/data/local/grupo_table.dart';
import '../../features/grupos/data/local/grupo_dao.dart';

// GrupoHorario (detalle de días/horas)
import '../../features/grupos/data/local/grupo_horario_table.dart';
import '../../features/grupos/data/local/grupo_horario_dao.dart';

// Matrícula (tabla puente N-M)
import '../../features/grupos/data/local/matricula_table.dart';
import '../../features/grupos/data/local/matricula_dao.dart';

part 'app_database.g.dart';

@Database(
  version: 1,
  entities: [
    ProgramaTable,
    PensumTable,
    AsignaturaTable,
    EstudianteTable,
    DocenteTable,
    GrupoTable,
    GrupoHorarioTable,
    MatriculaTable,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  // ====== GETTERS DE DAOS ======
  ProgramaDao get programaDao;
  PensumDao get pensumDao;
  AsignaturaDao get asignaturaDao;
  EstudianteDao get estudianteDao;
  DocenteDao get docenteDao;
  GrupoDao get grupoDao;
  GrupoHorarioDao get grupoHorarioDao;
  MatriculaDao get matriculaDao;
}
