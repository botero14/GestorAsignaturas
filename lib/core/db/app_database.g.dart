// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProgramaDao? _programaDaoInstance;

  PensumDao? _pensumDaoInstance;

  AsignaturaDao? _asignaturaDaoInstance;

  EstudianteDao? _estudianteDaoInstance;

  DocenteDao? _docenteDaoInstance;

  GrupoDao? _grupoDaoInstance;

  GrupoHorarioDao? _grupoHorarioDaoInstance;

  MatriculaDao? _matriculaDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `programas` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nombre` TEXT NOT NULL, `codigo` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `pensums` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `programaId` INTEGER NOT NULL, `nombre` TEXT NOT NULL, `anio` INTEGER NOT NULL, FOREIGN KEY (`programaId`) REFERENCES `programas` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `asignaturas` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `pensumId` INTEGER NOT NULL, `nombre` TEXT NOT NULL, `creditos` INTEGER NOT NULL, `area` TEXT NOT NULL, `habilitable` INTEGER NOT NULL, `semestre` INTEGER NOT NULL, `codigo` TEXT NOT NULL, `horasSemana` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `estudiantes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nombres` TEXT NOT NULL, `apellidos` TEXT NOT NULL, `correo` TEXT NOT NULL, `codigoEstudiante` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `docentes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nombres` TEXT NOT NULL, `apellidos` TEXT NOT NULL, `correo` TEXT NOT NULL, `titulo` TEXT NOT NULL, `vinculacion` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `grupos` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `asignaturaId` INTEGER NOT NULL, `docenteId` INTEGER, `capacidad` INTEGER NOT NULL, `anio` INTEGER NOT NULL, `periodo` TEXT NOT NULL, FOREIGN KEY (`asignaturaId`) REFERENCES `asignaturas` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`docenteId`) REFERENCES `docentes` (`id`) ON UPDATE NO ACTION ON DELETE RESTRICT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `grupos_horarios` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `grupoId` INTEGER NOT NULL, `diaSemana` INTEGER NOT NULL, `horaInicio` TEXT NOT NULL, `horaFin` TEXT NOT NULL, FOREIGN KEY (`grupoId`) REFERENCES `grupos` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `matriculas` (`estudianteId` INTEGER NOT NULL, `grupoId` INTEGER NOT NULL, `fechaIso` TEXT NOT NULL, FOREIGN KEY (`estudianteId`) REFERENCES `estudiantes` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`grupoId`) REFERENCES `grupos` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`estudianteId`, `grupoId`))');
        await database.execute(
            'CREATE UNIQUE INDEX `index_programas_codigo` ON `programas` (`codigo`)');
        await database.execute(
            'CREATE INDEX `index_pensums_programaId` ON `pensums` (`programaId`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_pensums_programaId_nombre` ON `pensums` (`programaId`, `nombre`)');
        await database.execute(
            'CREATE INDEX `index_asignaturas_pensumId` ON `asignaturas` (`pensumId`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_asignaturas_codigo` ON `asignaturas` (`codigo`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_estudiantes_correo` ON `estudiantes` (`correo`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_estudiantes_codigoEstudiante` ON `estudiantes` (`codigoEstudiante`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_docentes_correo` ON `docentes` (`correo`)');
        await database.execute(
            'CREATE INDEX `index_grupos_asignaturaId` ON `grupos` (`asignaturaId`)');
        await database.execute(
            'CREATE INDEX `index_grupos_docenteId` ON `grupos` (`docenteId`)');
        await database.execute(
            'CREATE INDEX `index_grupos_anio_periodo` ON `grupos` (`anio`, `periodo`)');
        await database.execute(
            'CREATE INDEX `index_grupos_horarios_grupoId` ON `grupos_horarios` (`grupoId`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_grupos_horarios_grupoId_diaSemana_horaInicio_horaFin` ON `grupos_horarios` (`grupoId`, `diaSemana`, `horaInicio`, `horaFin`)');
        await database.execute(
            'CREATE INDEX `index_matriculas_estudianteId` ON `matriculas` (`estudianteId`)');
        await database.execute(
            'CREATE INDEX `index_matriculas_grupoId` ON `matriculas` (`grupoId`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProgramaDao get programaDao {
    return _programaDaoInstance ??= _$ProgramaDao(database, changeListener);
  }

  @override
  PensumDao get pensumDao {
    return _pensumDaoInstance ??= _$PensumDao(database, changeListener);
  }

  @override
  AsignaturaDao get asignaturaDao {
    return _asignaturaDaoInstance ??= _$AsignaturaDao(database, changeListener);
  }

  @override
  EstudianteDao get estudianteDao {
    return _estudianteDaoInstance ??= _$EstudianteDao(database, changeListener);
  }

  @override
  DocenteDao get docenteDao {
    return _docenteDaoInstance ??= _$DocenteDao(database, changeListener);
  }

  @override
  GrupoDao get grupoDao {
    return _grupoDaoInstance ??= _$GrupoDao(database, changeListener);
  }

  @override
  GrupoHorarioDao get grupoHorarioDao {
    return _grupoHorarioDaoInstance ??=
        _$GrupoHorarioDao(database, changeListener);
  }

  @override
  MatriculaDao get matriculaDao {
    return _matriculaDaoInstance ??= _$MatriculaDao(database, changeListener);
  }
}

class _$ProgramaDao extends ProgramaDao {
  _$ProgramaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _programaTableInsertionAdapter = InsertionAdapter(
            database,
            'programas',
            (ProgramaTable item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'codigo': item.codigo
                }),
        _programaTableUpdateAdapter = UpdateAdapter(
            database,
            'programas',
            ['id'],
            (ProgramaTable item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'codigo': item.codigo
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProgramaTable> _programaTableInsertionAdapter;

  final UpdateAdapter<ProgramaTable> _programaTableUpdateAdapter;

  @override
  Future<List<ProgramaTable>> all() async {
    return _queryAdapter.queryList(
        'SELECT * FROM programas ORDER BY nombre ASC',
        mapper: (Map<String, Object?> row) => ProgramaTable(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            codigo: row['codigo'] as String));
  }

  @override
  Future<ProgramaTable?> byId(int id) async {
    return _queryAdapter.query('SELECT * FROM programas WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProgramaTable(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            codigo: row['codigo'] as String),
        arguments: [id]);
  }

  @override
  Future<int?> existsByCodigo(String codigo) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM programas WHERE codigo = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [codigo]);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM programas WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertOne(ProgramaTable row) {
    return _programaTableInsertionAdapter.insertAndReturnId(
        row, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateOne(ProgramaTable row) {
    return _programaTableUpdateAdapter.updateAndReturnChangedRows(
        row, OnConflictStrategy.abort);
  }
}

class _$PensumDao extends PensumDao {
  _$PensumDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pensumTableInsertionAdapter = InsertionAdapter(
            database,
            'pensums',
            (PensumTable item) => <String, Object?>{
                  'id': item.id,
                  'programaId': item.programaId,
                  'nombre': item.nombre,
                  'anio': item.anio
                }),
        _pensumTableUpdateAdapter = UpdateAdapter(
            database,
            'pensums',
            ['id'],
            (PensumTable item) => <String, Object?>{
                  'id': item.id,
                  'programaId': item.programaId,
                  'nombre': item.nombre,
                  'anio': item.anio
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PensumTable> _pensumTableInsertionAdapter;

  final UpdateAdapter<PensumTable> _pensumTableUpdateAdapter;

  @override
  Future<List<PensumTable>> all() async {
    return _queryAdapter.queryList(
        'SELECT * FROM pensums ORDER BY anio DESC, nombre ASC',
        mapper: (Map<String, Object?> row) => PensumTable(
            id: row['id'] as int?,
            programaId: row['programaId'] as int,
            nombre: row['nombre'] as String,
            anio: row['anio'] as int));
  }

  @override
  Future<PensumTable?> byId(int id) async {
    return _queryAdapter.query('SELECT * FROM pensums WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PensumTable(
            id: row['id'] as int?,
            programaId: row['programaId'] as int,
            nombre: row['nombre'] as String,
            anio: row['anio'] as int),
        arguments: [id]);
  }

  @override
  Future<List<PensumTable>> byPrograma(int programaId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM pensums WHERE programaId = ?1 ORDER BY anio DESC, nombre ASC',
        mapper: (Map<String, Object?> row) => PensumTable(id: row['id'] as int?, programaId: row['programaId'] as int, nombre: row['nombre'] as String, anio: row['anio'] as int),
        arguments: [programaId]);
  }

  @override
  Future<int?> existsNombreInPrograma(
    int programaId,
    String nombre,
  ) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM pensums WHERE programaId = ?1 AND nombre = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [programaId, nombre]);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM pensums WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertOne(PensumTable row) {
    return _pensumTableInsertionAdapter.insertAndReturnId(
        row, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateOne(PensumTable row) {
    return _pensumTableUpdateAdapter.updateAndReturnChangedRows(
        row, OnConflictStrategy.abort);
  }
}

class _$AsignaturaDao extends AsignaturaDao {
  _$AsignaturaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _asignaturaTableInsertionAdapter = InsertionAdapter(
            database,
            'asignaturas',
            (AsignaturaTable item) => <String, Object?>{
                  'id': item.id,
                  'pensumId': item.pensumId,
                  'nombre': item.nombre,
                  'creditos': item.creditos,
                  'area': item.area,
                  'habilitable': item.habilitable ? 1 : 0,
                  'semestre': item.semestre,
                  'codigo': item.codigo,
                  'horasSemana': item.horasSemana
                }),
        _asignaturaTableUpdateAdapter = UpdateAdapter(
            database,
            'asignaturas',
            ['id'],
            (AsignaturaTable item) => <String, Object?>{
                  'id': item.id,
                  'pensumId': item.pensumId,
                  'nombre': item.nombre,
                  'creditos': item.creditos,
                  'area': item.area,
                  'habilitable': item.habilitable ? 1 : 0,
                  'semestre': item.semestre,
                  'codigo': item.codigo,
                  'horasSemana': item.horasSemana
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AsignaturaTable> _asignaturaTableInsertionAdapter;

  final UpdateAdapter<AsignaturaTable> _asignaturaTableUpdateAdapter;

  @override
  Future<List<AsignaturaTable>> all() async {
    return _queryAdapter.queryList(
        'SELECT * FROM asignaturas ORDER BY semestre ASC, nombre ASC',
        mapper: (Map<String, Object?> row) => AsignaturaTable(
            id: row['id'] as int?,
            pensumId: row['pensumId'] as int,
            nombre: row['nombre'] as String,
            creditos: row['creditos'] as int,
            area: row['area'] as String,
            habilitable: (row['habilitable'] as int) != 0,
            semestre: row['semestre'] as int,
            codigo: row['codigo'] as String,
            horasSemana: row['horasSemana'] as int));
  }

  @override
  Future<AsignaturaTable?> byId(int id) async {
    return _queryAdapter.query('SELECT * FROM asignaturas WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AsignaturaTable(
            id: row['id'] as int?,
            pensumId: row['pensumId'] as int,
            nombre: row['nombre'] as String,
            creditos: row['creditos'] as int,
            area: row['area'] as String,
            habilitable: (row['habilitable'] as int) != 0,
            semestre: row['semestre'] as int,
            codigo: row['codigo'] as String,
            horasSemana: row['horasSemana'] as int),
        arguments: [id]);
  }

  @override
  Future<List<AsignaturaTable>> byPensum(int pensumId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM asignaturas WHERE pensumId = ?1 ORDER BY semestre ASC, nombre ASC',
        mapper: (Map<String, Object?> row) => AsignaturaTable(id: row['id'] as int?, pensumId: row['pensumId'] as int, nombre: row['nombre'] as String, creditos: row['creditos'] as int, area: row['area'] as String, habilitable: (row['habilitable'] as int) != 0, semestre: row['semestre'] as int, codigo: row['codigo'] as String, horasSemana: row['horasSemana'] as int),
        arguments: [pensumId]);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM asignaturas WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int> insertOne(AsignaturaTable row) {
    return _asignaturaTableInsertionAdapter.insertAndReturnId(
        row, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateOne(AsignaturaTable row) {
    return _asignaturaTableUpdateAdapter.updateAndReturnChangedRows(
        row, OnConflictStrategy.abort);
  }
}

class _$EstudianteDao extends EstudianteDao {
  _$EstudianteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _estudianteTableInsertionAdapter = InsertionAdapter(
            database,
            'estudiantes',
            (EstudianteTable item) => <String, Object?>{
                  'id': item.id,
                  'nombres': item.nombres,
                  'apellidos': item.apellidos,
                  'correo': item.correo,
                  'codigoEstudiante': item.codigoEstudiante
                }),
        _estudianteTableUpdateAdapter = UpdateAdapter(
            database,
            'estudiantes',
            ['id'],
            (EstudianteTable item) => <String, Object?>{
                  'id': item.id,
                  'nombres': item.nombres,
                  'apellidos': item.apellidos,
                  'correo': item.correo,
                  'codigoEstudiante': item.codigoEstudiante
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EstudianteTable> _estudianteTableInsertionAdapter;

  final UpdateAdapter<EstudianteTable> _estudianteTableUpdateAdapter;

  @override
  Future<List<EstudianteTable>> all() async {
    return _queryAdapter.queryList(
        'SELECT * FROM estudiantes ORDER BY apellidos ASC, nombres ASC',
        mapper: (Map<String, Object?> row) => EstudianteTable(
            id: row['id'] as int?,
            nombres: row['nombres'] as String,
            apellidos: row['apellidos'] as String,
            correo: row['correo'] as String,
            codigoEstudiante: row['codigoEstudiante'] as String));
  }

  @override
  Future<EstudianteTable?> byId(int id) async {
    return _queryAdapter.query('SELECT * FROM estudiantes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => EstudianteTable(
            id: row['id'] as int?,
            nombres: row['nombres'] as String,
            apellidos: row['apellidos'] as String,
            correo: row['correo'] as String,
            codigoEstudiante: row['codigoEstudiante'] as String),
        arguments: [id]);
  }

  @override
  Future<int?> countByCorreo(String correo) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM estudiantes WHERE correo = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [correo]);
  }

  @override
  Future<int?> countByCodigo(String codigo) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM estudiantes WHERE codigoEstudiante = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [codigo]);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM estudiantes WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int> insertOne(EstudianteTable row) {
    return _estudianteTableInsertionAdapter.insertAndReturnId(
        row, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateOne(EstudianteTable row) {
    return _estudianteTableUpdateAdapter.updateAndReturnChangedRows(
        row, OnConflictStrategy.abort);
  }
}

class _$DocenteDao extends DocenteDao {
  _$DocenteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _docenteTableInsertionAdapter = InsertionAdapter(
            database,
            'docentes',
            (DocenteTable item) => <String, Object?>{
                  'id': item.id,
                  'nombres': item.nombres,
                  'apellidos': item.apellidos,
                  'correo': item.correo,
                  'titulo': item.titulo,
                  'vinculacion': item.vinculacion
                }),
        _docenteTableUpdateAdapter = UpdateAdapter(
            database,
            'docentes',
            ['id'],
            (DocenteTable item) => <String, Object?>{
                  'id': item.id,
                  'nombres': item.nombres,
                  'apellidos': item.apellidos,
                  'correo': item.correo,
                  'titulo': item.titulo,
                  'vinculacion': item.vinculacion
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DocenteTable> _docenteTableInsertionAdapter;

  final UpdateAdapter<DocenteTable> _docenteTableUpdateAdapter;

  @override
  Future<List<DocenteTable>> all() async {
    return _queryAdapter.queryList(
        'SELECT * FROM docentes ORDER BY apellidos ASC, nombres ASC',
        mapper: (Map<String, Object?> row) => DocenteTable(
            id: row['id'] as int?,
            nombres: row['nombres'] as String,
            apellidos: row['apellidos'] as String,
            correo: row['correo'] as String,
            titulo: row['titulo'] as String,
            vinculacion: row['vinculacion'] as String));
  }

  @override
  Future<DocenteTable?> byId(int id) async {
    return _queryAdapter.query('SELECT * FROM docentes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DocenteTable(
            id: row['id'] as int?,
            nombres: row['nombres'] as String,
            apellidos: row['apellidos'] as String,
            correo: row['correo'] as String,
            titulo: row['titulo'] as String,
            vinculacion: row['vinculacion'] as String),
        arguments: [id]);
  }

  @override
  Future<int?> countByCorreo(String correo) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM docentes WHERE correo = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [correo]);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM docentes WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertOne(DocenteTable row) {
    return _docenteTableInsertionAdapter.insertAndReturnId(
        row, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateOne(DocenteTable row) {
    return _docenteTableUpdateAdapter.updateAndReturnChangedRows(
        row, OnConflictStrategy.abort);
  }
}

class _$GrupoDao extends GrupoDao {
  _$GrupoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _grupoTableInsertionAdapter = InsertionAdapter(
            database,
            'grupos',
            (GrupoTable item) => <String, Object?>{
                  'id': item.id,
                  'asignaturaId': item.asignaturaId,
                  'docenteId': item.docenteId,
                  'capacidad': item.capacidad,
                  'anio': item.anio,
                  'periodo': item.periodo
                }),
        _grupoTableUpdateAdapter = UpdateAdapter(
            database,
            'grupos',
            ['id'],
            (GrupoTable item) => <String, Object?>{
                  'id': item.id,
                  'asignaturaId': item.asignaturaId,
                  'docenteId': item.docenteId,
                  'capacidad': item.capacidad,
                  'anio': item.anio,
                  'periodo': item.periodo
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GrupoTable> _grupoTableInsertionAdapter;

  final UpdateAdapter<GrupoTable> _grupoTableUpdateAdapter;

  @override
  Future<List<GrupoTable>> all() async {
    return _queryAdapter.queryList(
        'SELECT * FROM grupos ORDER BY anio DESC, periodo DESC, id DESC',
        mapper: (Map<String, Object?> row) => GrupoTable(
            id: row['id'] as int?,
            asignaturaId: row['asignaturaId'] as int,
            docenteId: row['docenteId'] as int?,
            capacidad: row['capacidad'] as int,
            anio: row['anio'] as int,
            periodo: row['periodo'] as String));
  }

  @override
  Future<GrupoTable?> byId(int id) async {
    return _queryAdapter.query('SELECT * FROM grupos WHERE id = ?1',
        mapper: (Map<String, Object?> row) => GrupoTable(
            id: row['id'] as int?,
            asignaturaId: row['asignaturaId'] as int,
            docenteId: row['docenteId'] as int?,
            capacidad: row['capacidad'] as int,
            anio: row['anio'] as int,
            periodo: row['periodo'] as String),
        arguments: [id]);
  }

  @override
  Future<List<GrupoTable>> byAsignatura(int asignaturaId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM grupos WHERE asignaturaId = ?1 ORDER BY anio DESC, periodo DESC',
        mapper: (Map<String, Object?> row) => GrupoTable(id: row['id'] as int?, asignaturaId: row['asignaturaId'] as int, docenteId: row['docenteId'] as int?, capacidad: row['capacidad'] as int, anio: row['anio'] as int, periodo: row['periodo'] as String),
        arguments: [asignaturaId]);
  }

  @override
  Future<List<GrupoTable>> byDocente(int docenteId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM grupos WHERE docenteId = ?1 ORDER BY anio DESC, periodo DESC',
        mapper: (Map<String, Object?> row) => GrupoTable(id: row['id'] as int?, asignaturaId: row['asignaturaId'] as int, docenteId: row['docenteId'] as int?, capacidad: row['capacidad'] as int, anio: row['anio'] as int, periodo: row['periodo'] as String),
        arguments: [docenteId]);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM grupos WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertOne(GrupoTable row) {
    return _grupoTableInsertionAdapter.insertAndReturnId(
        row, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateOne(GrupoTable row) {
    return _grupoTableUpdateAdapter.updateAndReturnChangedRows(
        row, OnConflictStrategy.abort);
  }
}

class _$GrupoHorarioDao extends GrupoHorarioDao {
  _$GrupoHorarioDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _grupoHorarioTableInsertionAdapter = InsertionAdapter(
            database,
            'grupos_horarios',
            (GrupoHorarioTable item) => <String, Object?>{
                  'id': item.id,
                  'grupoId': item.grupoId,
                  'diaSemana': item.diaSemana,
                  'horaInicio': item.horaInicio,
                  'horaFin': item.horaFin
                }),
        _grupoHorarioTableUpdateAdapter = UpdateAdapter(
            database,
            'grupos_horarios',
            ['id'],
            (GrupoHorarioTable item) => <String, Object?>{
                  'id': item.id,
                  'grupoId': item.grupoId,
                  'diaSemana': item.diaSemana,
                  'horaInicio': item.horaInicio,
                  'horaFin': item.horaFin
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GrupoHorarioTable> _grupoHorarioTableInsertionAdapter;

  final UpdateAdapter<GrupoHorarioTable> _grupoHorarioTableUpdateAdapter;

  @override
  Future<List<GrupoHorarioTable>> byGrupo(int grupoId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM grupos_horarios WHERE grupoId = ?1 ORDER BY diaSemana ASC, horaInicio ASC',
        mapper: (Map<String, Object?> row) => GrupoHorarioTable(id: row['id'] as int?, grupoId: row['grupoId'] as int, diaSemana: row['diaSemana'] as int, horaInicio: row['horaInicio'] as String, horaFin: row['horaFin'] as String),
        arguments: [grupoId]);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM grupos_horarios WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int?> countOverlaps(
    int grupoId,
    int diaSemana,
    String inicio,
    String fin,
    int excludeId,
  ) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM grupos_horarios     WHERE grupoId = ?1 AND diaSemana = ?2       AND NOT (horaFin <= ?3 OR horaInicio >= ?4)       AND (?5 = -1 OR id != ?5)',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [grupoId, diaSemana, inicio, fin, excludeId]);
  }

  @override
  Future<int> insertOne(GrupoHorarioTable row) {
    return _grupoHorarioTableInsertionAdapter.insertAndReturnId(
        row, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateOne(GrupoHorarioTable row) {
    return _grupoHorarioTableUpdateAdapter.updateAndReturnChangedRows(
        row, OnConflictStrategy.abort);
  }
}

class _$MatriculaDao extends MatriculaDao {
  _$MatriculaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _matriculaTableInsertionAdapter = InsertionAdapter(
            database,
            'matriculas',
            (MatriculaTable item) => <String, Object?>{
                  'estudianteId': item.estudianteId,
                  'grupoId': item.grupoId,
                  'fechaIso': item.fechaIso
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MatriculaTable> _matriculaTableInsertionAdapter;

  @override
  Future<List<MatriculaTable>> byGrupo(int grupoId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM matriculas WHERE grupoId = ?1 ORDER BY fechaIso ASC',
        mapper: (Map<String, Object?> row) => MatriculaTable(
            estudianteId: row['estudianteId'] as int,
            grupoId: row['grupoId'] as int,
            fechaIso: row['fechaIso'] as String),
        arguments: [grupoId]);
  }

  @override
  Future<List<MatriculaTable>> byEstudiante(int estudianteId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM matriculas WHERE estudianteId = ?1 ORDER BY fechaIso DESC',
        mapper: (Map<String, Object?> row) => MatriculaTable(estudianteId: row['estudianteId'] as int, grupoId: row['grupoId'] as int, fechaIso: row['fechaIso'] as String),
        arguments: [estudianteId]);
  }

  @override
  Future<int?> countInGrupo(int grupoId) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM matriculas WHERE grupoId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [grupoId]);
  }

  @override
  Future<int?> existsEnrollment(
    int estudianteId,
    int grupoId,
  ) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM matriculas WHERE estudianteId = ?1 AND grupoId = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [estudianteId, grupoId]);
  }

  @override
  Future<void> deleteOne(
    int estudianteId,
    int grupoId,
  ) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM matriculas WHERE estudianteId = ?1 AND grupoId = ?2',
        arguments: [estudianteId, grupoId]);
  }

  @override
  Future<void> insertOne(MatriculaTable row) async {
    await _matriculaTableInsertionAdapter.insert(row, OnConflictStrategy.abort);
  }
}
