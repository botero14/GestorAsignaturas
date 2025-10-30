import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// DB (Floor)
import 'core/db/app_database.dart';

// Asignaturas (repo + vm + page)
import 'features/asignaturas/data/repositories/asignatura_repository_impl.dart';
import 'features/asignaturas/viewmodel/asignaturas_vm.dart';
import 'features/asignaturas/view/pages/asignaturas_page.dart';

// Opcional: tema rápido con tus colores institucionales
class AppColors {
  static const orange = Color(0xFFF5A536);
  static const teal = Color(0xFF21B2B7);
  static const red = Color(0xFFE55C4F);
}

ThemeData _appTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: AppColors.teal).copyWith(
    primary: AppColors.teal,
    secondary: AppColors.orange,
    tertiary: AppColors.red,
    onPrimary: Colors.white,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: Typography.blackMountainView,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Color(0xFFF7F7F7),
    ),
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Construye la base de datos (solo con Asignatura por ahora)
  final db = await $FloorAppDatabase.databaseBuilder('app.db').build();

  // Inyecta el repositorio de Asignaturas
  final asignaturasRepo = AsignaturaRepositoryImpl(db.asignaturaDao);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AsignaturasVM(asignaturasRepo)),
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
      theme: _appTheme(),
      home: const AsignaturasPage(), // pantalla de prueba
    );
  }
}
