import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/estudiante.dart';
import '../../viewmodel/estudiantes_vm.dart';

class EstudiantesPage extends StatefulWidget {
  const EstudiantesPage({super.key});

  @override
  State<EstudiantesPage> createState() => _EstudiantesPageState();
}

class _EstudiantesPageState extends State<EstudiantesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<EstudiantesVM>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EstudiantesVM>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes'),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, vm),
        child: const Icon(Icons.person_add_alt_1),
      ),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (vm.lastError != null)
                  Container(
                    width: double.infinity,
                    color: Colors.red.withOpacity(0.1),
                    padding: const EdgeInsets.all(12),
                    child: Text(vm.lastError!, style: const TextStyle(color: Colors.red)),
                  ),
                Expanded(
                  child: ListView.separated(
                    itemCount: vm.items.length,
                    separatorBuilder: (_, __) => const Divider(height: 0),
                    itemBuilder: (_, i) {
                      final e = vm.items[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: cs.secondaryContainer,
                          child: Text(e.nombres.isNotEmpty ? e.nombres[0].toUpperCase() : '?'),
                        ),
                        title: Text('${e.nombres} ${e.apellidos}'),
                        subtitle: Text('${e.correo} • ${e.codigoEstudiante}'),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => _showForm(context, vm, edit: e),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => vm.remove(e.id!),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _showForm(BuildContext context, EstudiantesVM vm, {Estudiante? edit}) async {
    final nombres = TextEditingController(text: edit?.nombres ?? '');
    final apellidos = TextEditingController(text: edit?.apellidos ?? '');
    final correo = TextEditingController(text: edit?.correo ?? '');
    final codigo = TextEditingController(text: edit?.codigoEstudiante ?? '');
    String? errorMsg;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setS) => AlertDialog(
          title: Text(edit == null ? 'Nuevo estudiante' : 'Editar estudiante'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nombres, decoration: const InputDecoration(labelText: 'Nombres')),
                const SizedBox(height: 8),
                TextField(controller: apellidos, decoration: const InputDecoration(labelText: 'Apellidos')),
                const SizedBox(height: 8),
                TextField(controller: correo, decoration: const InputDecoration(labelText: 'Correo')),
                const SizedBox(height: 8),
                TextField(controller: codigo, decoration: const InputDecoration(labelText: 'Código de estudiante')),
                if (errorMsg != null) ...[
                  const SizedBox(height: 8),
                  Text(errorMsg!, style: const TextStyle(color: Colors.red)),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () async {
                final est = Estudiante(
                  id: edit?.id,
                  nombres: nombres.text.trim(),
                  apellidos: apellidos.text.trim(),
                  correo: correo.text.trim(),
                  codigoEstudiante: codigo.text.trim(),
                );
                if (edit == null) {
                  final ok = await vm.add(est);
                  if (!ok) {
                    setS(() => errorMsg = vm.lastError);
                    return;
                  }
                } else {
                  await vm.update(est);
                }
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
