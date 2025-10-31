import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/pensum.dart';
import '../../viewmodel/pensum_vm.dart';

class PensumsPage extends StatefulWidget {
  const PensumsPage({super.key});

  @override
  State<PensumsPage> createState() => _PensumsPageState();
}

class _PensumsPageState extends State<PensumsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PensumsVM>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PensumsVM>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pensums'),
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
                    child: Text(p.anio.toString()),
                  ),
                  title: Text(p.nombre),
                  subtitle: Text(
                    'ProgramaId: ${p.programaId} • Año: ${p.anio}',
                  ),
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
    PensumsVM vm, {
    Pensum? edit,
  }) async {
    final programaId = TextEditingController(
      text: (edit?.programaId ?? '').toString(),
    );
    final nombre = TextEditingController(text: edit?.nombre ?? '');
    final anio = TextEditingController(text: (edit?.anio ?? '').toString());
    String? errorMsg;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setS) => AlertDialog(
          title: Text(edit == null ? 'Nuevo pensum' : 'Editar pensum'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: programaId,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Programa ID'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nombre,
                  decoration: const InputDecoration(
                    labelText: 'Nombre/Versión',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: anio,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Año'),
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
                final p = Pensum(
                  id: edit?.id,
                  programaId: int.tryParse(programaId.text.trim()) ?? 0,
                  nombre: nombre.text.trim(),
                  anio: int.tryParse(anio.text.trim()) ?? 0,
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
