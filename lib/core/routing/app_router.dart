import 'package:flutter/material.dart';

// ====== Imports de páginas (ajusta si cambias los nombres/paths) ======
import '../../features/programas/view/pages/programas_page.dart';
import '../../features/pensums/view/pages/pensum_page.dart';
import '../../features/asignaturas/view/pages/asignaturas_page.dart';
import '../../features/estudiantes/view/pages/estudiantes_page.dart';
import '../../features/grupos/view/pages/grupo_page.dart';

// (Opcionales si manejas formularios/pantallas detalle por ruta)
// import '../../features/programas/view/pages/programa_form_page.dart';
// import '../../features/grupos/view/pages/grupo_detalle_page.dart';

/// Nombres de rutas centralizados para evitar “strings mágicos”
class AppRoutes {
  // Home(s)
  static const home = grupos; // ruta inicial
  static const grupos = '/grupos';
  static const programas = '/programas';
  static const pensums = '/pensums';
  static const asignaturas = '/asignaturas';
  static const estudiantes = '/estudiantes';

  // (Opcionales / ejemplo de rutas con argumentos)
  static const grupoDetalle = '/grupos/detalle'; // requiere args: {grupoId:int}
  static const programaForm = '/programas/form'; // args opcionales para editar
}

/// Registro estático de rutas “simples” (sin argumentos)
class AppRouter {
  /// Mapa para `MaterialApp.routes`
  static Map<String, WidgetBuilder> routes() => {
    AppRoutes.grupos: (_) => const GruposPage(),
    AppRoutes.programas: (_) => const ProgramasPage(),
    AppRoutes.pensums: (_) => const PensumsPage(),
    AppRoutes.asignaturas: (_) => const AsignaturasPage(),
    AppRoutes.estudiantes: (_) => const EstudiantesPage(),
  };

  /// Constructor de rutas para **pantallas con argumentos**.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    final args = settings.arguments;

    if (name == AppRoutes.grupoDetalle) {
      final map = (args is Map) ? args : <String, dynamic>{};
      final grupoId = map['grupoId'] as int?;
      if (grupoId == null) {
        return _error('Falta argumento: grupoId');
      }
      // return MaterialPageRoute(builder: (_) => GrupoDetallePage(grupoId: grupoId));
      return _error('Implementa GrupoDetallePage(grupoId: $grupoId)');
    }

    if (name == AppRoutes.programaForm) {
      // final map = (args is Map) ? args : <String, dynamic>{};
      // final programaId = map['id'] as int?;
      // return MaterialPageRoute(builder: (_) => ProgramaFormPage(programaId: programaId));
      return _error('Implementa ProgramaFormPage(programaId)');
    }

    return _notFound(name);
  }

  // Helpers para rutas no encontradas / error de argumentos
  static MaterialPageRoute _notFound(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Ruta no encontrada')),
        body: Center(child: Text('No existe la ruta: $name')),
      ),
    );
  }

  static MaterialPageRoute _error(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error de navegación')),
        body: Center(child: Text(message)),
      ),
    );
  }
}
