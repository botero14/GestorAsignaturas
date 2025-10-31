import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/docente.dart';
import '../../viewmodel/docente_vm.dart';

class DocentesPage extends StatefulWidget {
  const DocentesPage({super.key});

  @override
  State<DocentesPage> createState() => _DocentesPageState();
}

class _DocentesPageState extends State<DocentesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<DocentesVM>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DocentesVM>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Docentes'),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, vm),
        child: const Icon(Icons.person_add),
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
                    child: Text(
                      vm.lastError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                Expanded(
                  child: ListView.separated(
                    itemCount: vm.items.length,
                    separatorBuilder: (_, __) => const Divider(height: 0),
                    itemBuilder: (_, i) {
                      final d = vm.items[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: cs.secondaryContainer,
                          child: Text(
                            d.nombres.isNotEmpty
                                ? d.nombres[0].toUpperCase()
                                : '?',
                          ),
                        ),
                        title: Text('${d.nombres} ${d.apellidos}'),
                        subtitle: Text(
                          '${d.titulo} • ${d.vinculacion} • ${d.correo}',
                        ),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => _showForm(context, vm, edit: d),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () => vm.remove(d.id!),
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

  Future<void> _showForm(
    BuildContext context,
    DocentesVM vm, {
    Docente? edit,
  }) async {
    final nombres = TextEditingController(text: edit?.nombres ?? '');
    final apellidos = TextEditingController(text: edit?.apellidos ?? '');
    final correo = TextEditingController(text: edit?.correo ?? '');
    final titulo = TextEditingController(text: edit?.titulo ?? '');
    final vinculacion = TextEditingController(text: edit?.vinculacion ?? '');
    String? errorMsg;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setS) => AlertDialog(
          title: Text(edit == null ? 'Nuevo docente' : 'Editar docente'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nombres,
                  decoration: const InputDecoration(labelText: 'Nombres'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: apellidos,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: correo,
                  decoration: const InputDecoration(labelText: 'Correo'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: titulo,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: vinculacion,
                  decoration: const InputDecoration(
                    labelText: 'Vinculación (Catedratico/Ocasional/Planta)',
                  ),
                ),
                if (errorMsg != null) ...[
                  const SizedBox(height: 8),
                  Text(errorMsg!, style: const TextStyle(color: Colors.red)),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                final d = Docente(
                  id: edit?.id,
                  nombres: nombres.text.trim(),
                  apellidos: apellidos.text.trim(),
                  correo: correo.text.trim(),
                  titulo: titulo.text.trim(),
                  vinculacion: vinculacion.text.trim(),
                );
                if (edit == null) {
                  final ok = await vm.add(d);
                  if (!ok) {
                    setS(() => errorMsg = vm.lastError);
                    return;
                  }
                } else {
                  await vm.update(d);
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
