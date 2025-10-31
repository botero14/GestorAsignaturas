// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Core
import 'core/db/app_database.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';

// ====== Repositorios + ViewModels ======
// Programas
import 'features/programas/data/repositories/programa_repository_impl.dart';
import 'features/programas/viewmodel/programas_vm.dart';

// Pensums
import 'features/pensums/data/repositories/pensum_repository_impl.dart';
import 'features/pensums/viewmodel/pensum_vm.dart';

// Asignaturas
import 'features/asignaturas/data/repositories/asignatura_repository_impl.dart';
import 'features/asignaturas/viewmodel/asignaturas_vm.dart';

// Estudiantes
import 'features/estudiantes/data/repositories/estudiante_repository_impl.dart';
import 'features/estudiantes/viewmodel/estudiantes_vm.dart';

// Docentes
import 'features/docentes/data/repositories/docente_repository_impl.dart';
import 'features/docentes/viewmodel/docente_vm.dart';

// Grupos
import 'features/grupos/data/repositories/grupos_repository_impl.dart';
import 'features/grupos/viewmodel/grupos_vm.dart';

// GrupoHorario
import 'features/grupos/data/repositories/grupo_horario_repository_impl.dart';
import 'features/grupos/viewmodel/grupo_horario_vm.dart';

// Matrículas
import 'features/grupos/data/repositories/matricula_repository_impl.dart';
import 'features/grupos/viewmodel/matriculas_vm.dart';

// ====== Páginas (para el AppShell) ======
import 'features/programas/view/pages/programas_page.dart';
import 'features/pensums/view/pages/pensum_page.dart';
import 'features/asignaturas/view/pages/asignaturas_page.dart';
import 'features/estudiantes/view/pages/estudiantes_page.dart';
import 'features/docentes/view/pages/docente_page.dart';
import 'features/grupos/view/pages/grupo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DB con todas las entidades registradas en app_database.dart
  final db = await $FloorAppDatabase.databaseBuilder('app.db').build();

  // Repos
  final programaRepo = ProgramaRepositoryImpl(db.programaDao);
  final pensumRepo = PensumRepositoryImpl(db.pensumDao);
  final asignaturaRepo = AsignaturaRepositoryImpl(db.asignaturaDao);
  final estudianteRepo = EstudianteRepositoryImpl(db.estudianteDao);
  final docenteRepo = DocenteRepositoryImpl(db.docenteDao);
  final gruposRepo = GruposRepositoryImpl(db.grupoDao);
  final grupoHorRepo = GrupoHorarioRepositoryImpl(db.grupoHorarioDao);
  final matriculaRepo = MatriculaRepositoryImpl(db.matriculaDao);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProgramasVM(programaRepo)),
        ChangeNotifierProvider(create: (_) => PensumsVM(pensumRepo)),
        ChangeNotifierProvider(create: (_) => AsignaturasVM(asignaturaRepo)),
        ChangeNotifierProvider(create: (_) => EstudiantesVM(estudianteRepo)),
        ChangeNotifierProvider(create: (_) => DocentesVM(docenteRepo)),
        ChangeNotifierProvider(
          create: (_) => GruposVM(gruposRepo, asignaturaRepo, docenteRepo),
        ),
        ChangeNotifierProvider(create: (_) => GrupoHorarioVM(grupoHorRepo)),
        ChangeNotifierProvider(
          create: (_) => MatriculasVM(
            matriculaRepo,
            gruposRepo,
            estudianteRepo,
            asigRepo: asignaturaRepo,
            docRepo: docenteRepo,
          ),
        ),
      ],
      child: const _App(),
    ),
  );
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      // Puedes seguir usando rutas nombradas:
      initialRoute: AppRoutes.home,
      routes: AppRouter.routes(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      // Y además damos una “home” con bottom nav para navegar fácil:
      home: const _AppShell(),
    );
  }
}

/// Shell con BottomNavigation para moverte entre módulos sin depender
/// de que cada página tenga botones/menús propios.
class _AppShell extends StatefulWidget {
  const _AppShell({super.key});

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int _index = 5; // arrancamos en Grupos (0..5)

  final _pages = const <Widget>[
    ProgramasPage(),
    PensumsPage(),
    AsignaturasPage(),
    EstudiantesPage(),
    DocentesPage(),
    GruposPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            label: 'Programas',
          ),
          NavigationDestination(
            icon: Icon(Icons.view_list_outlined),
            label: 'Pensums',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Asignaturas',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            label: 'Estudiantes',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Docentes',
          ),
          NavigationDestination(
            icon: Icon(Icons.class_outlined),
            label: 'Grupos',
          ),
        ],
      ),
    );
  }
}
