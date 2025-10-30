// lib/core/db/app_database.dart
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

// === IMPORTA SOLO LO QUE USARÁS AHORA (Asignaturas) ===
import '../../features/asignaturas/data/local/asignatura_table.dart';
import '../../features/asignaturas/data/local/asignatura_dao.dart';

part 'app_database.g.dart'; // <- generado por build_runner

@Database(
  version: 1,
  entities: [
    AsignaturaTable,
    // Cuando agregues más entidades, las sumas aquí.
  ],
)
abstract class AppDatabase extends FloorDatabase {
  AsignaturaDao get asignaturaDao;
}
