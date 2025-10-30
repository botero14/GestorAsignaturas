import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/asignatura.dart';
import '../../viewmodel/asignaturas_vm.dart';

class AsignaturasPage extends StatefulWidget {
  const AsignaturasPage({super.key});

  @override
  State<AsignaturasPage> createState() => _AsignaturasPageState();
}

class _AsignaturasPageState extends State<AsignaturasPage> {
  @override
  void initState() {
    super.initState();
    // Carga inicial (sin filtro por pensum)
    Future.microtask(() => context.read<AsignaturasVM>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AsignaturasVM>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignaturas'),
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
                final a = vm.items[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: cs.secondaryContainer,
                    child: Text(a.semestre.toString()),
                  ),
                  title: Text('${a.nombre} • ${a.creditos} créditos'),
                  subtitle: Text(
                    '${a.area} • Código: ${a.codigo} • ${a.habilitable ? "Habilitable" : "No habilitable"}',
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _showForm(context, vm, edit: a),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () => vm.remove(a.id!),
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
    AsignaturasVM vm, {
    Asignatura? edit,
  }) async {
    final pensumId = TextEditingController(
      text: (edit?.pensumId ?? '').toString(),
    );
    final nombre = TextEditingController(text: edit?.nombre ?? '');
    final creditos = TextEditingController(
      text: (edit?.creditos ?? '').toString(),
    );
    final area = TextEditingController(text: edit?.area ?? '');
    final habilitable = ValueNotifier<bool>(edit?.habilitable ?? true);
    final semestre = TextEditingController(
      text: (edit?.semestre ?? '').toString(),
    );
    final codigo = TextEditingController(text: edit?.codigo ?? '');
    final horas = TextEditingController(
      text: (edit?.horasSemana ?? '').toString(),
    );

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(edit == null ? 'Nueva asignatura' : 'Editar asignatura'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: pensumId,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Pensum ID'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: creditos,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Créditos'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: area,
                decoration: const InputDecoration(labelText: 'Área'),
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder<bool>(
                valueListenable: habilitable,
                builder: (_, v, __) => SwitchListTile(
                  value: v,
                  onChanged: (nv) => habilitable.value = nv,
                  title: const Text('Habilitable'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: semestre,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Semestre (1..10)',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: codigo,
                decoration: const InputDecoration(labelText: 'Código (único)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: horas,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Horas/semana'),
              ),
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
              final a = Asignatura(
                id: edit?.id,
                pensumId: int.tryParse(pensumId.text.trim()) ?? 0,
                nombre: nombre.text.trim(),
                creditos: int.tryParse(creditos.text.trim()) ?? 0,
                area: area.text.trim(),
                habilitable: habilitable.value,
                semestre: int.tryParse(semestre.text.trim()) ?? 1,
                codigo: codigo.text.trim(),
                horasSemana: int.tryParse(horas.text.trim()) ?? 0,
              );
              if (edit == null) {
                await vm.add(a);
              } else {
                await vm.update(a);
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
