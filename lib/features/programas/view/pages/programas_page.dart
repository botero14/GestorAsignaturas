import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/programa.dart';
import '../../viewmodel/programas_vm.dart';

class ProgramasPage extends StatefulWidget {
  const ProgramasPage({super.key});

  @override
  State<ProgramasPage> createState() => _ProgramasPageState();
}

class _ProgramasPageState extends State<ProgramasPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProgramasVM>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProgramasVM>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Programas'),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, vm),
        child: const Icon(Icons.add),
      ),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: vm.items.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (_, i) {
                final p = vm.items[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: cs.secondaryContainer,
                    child: Text(
                      p.nombre.isNotEmpty ? p.nombre[0].toUpperCase() : '?',
                    ),
                  ),
                  title: Text(p.nombre),
                  subtitle: Text('Código: ${p.codigo}'),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _showForm(context, vm, edit: p),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () => vm.remove(p.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<void> _showForm(
    BuildContext context,
    ProgramasVM vm, {
    Programa? edit,
  }) async {
    final nombre = TextEditingController(text: edit?.nombre ?? '');
    final codigo = TextEditingController(text: edit?.codigo ?? '');
    String? errorMsg;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setS) => AlertDialog(
          title: Text(edit == null ? 'Nuevo programa' : 'Editar programa'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nombre,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: codigo,
                  decoration: const InputDecoration(labelText: 'Código'),
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
                final p = Programa(
                  id: edit?.id,
                  nombre: nombre.text.trim(),
                  codigo: codigo.text.trim(),
                );
                if (edit == null) {
                  final err = await vm.add(p);
                  if (err != null) {
                    setS(() => errorMsg = err);
                    return;
                  }
                } else {
                  await vm.update(p);
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
