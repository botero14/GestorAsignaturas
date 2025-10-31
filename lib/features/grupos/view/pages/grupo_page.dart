import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/grupo.dart';
import '../../viewmodel/grupos_vm.dart';

class GruposPage extends StatefulWidget {
  const GruposPage({super.key});

  @override
  State<GruposPage> createState() => _GruposPageState();
}

class _GruposPageState extends State<GruposPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<GruposVM>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GruposVM>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos'),
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
                final g = vm.items[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: cs.secondaryContainer,
                    child: Text(g.periodo),
                  ),
                  title: Text(
                    '${vm.nombreAsignatura(g.asignaturaId)} • ${g.anio}-${g.periodo}',
                  ),
                  subtitle: Text(
                    'Docente: ${vm.nombreDocente(g.docenteId)}  • Capacidad: ${g.capacidad}',
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _showForm(context, vm, edit: g),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () => vm.remove(g.id!),
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
    GruposVM vm, {
    Grupo? edit,
  }) async {
    // dropdown data
    final asignaturas = vm.asignaturas;
    final docentes = vm.docentes;

    int? asignaturaId =
        edit?.asignaturaId ??
        (asignaturas.isNotEmpty ? asignaturas.first.id : null);
    int? docenteId = edit?.docenteId;
    final capacidad = TextEditingController(
      text: (edit?.capacidad ?? 30).toString(),
    );
    final anio = TextEditingController(
      text: (edit?.anio ?? DateTime.now().year).toString(),
    );
    String periodo = edit?.periodo ?? '01';

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(edit == null ? 'Nuevo grupo' : 'Editar grupo'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              // Asignatura
              DropdownButtonFormField<int>(
                value: asignaturaId,
                items: asignaturas
                    .map(
                      (a) =>
                          DropdownMenuItem(value: a.id, child: Text(a.nombre)),
                    )
                    .toList(),
                onChanged: (v) => asignaturaId = v,
                decoration: const InputDecoration(labelText: 'Asignatura'),
              ),
              const SizedBox(height: 8),
              // Docente (opcional)
              DropdownButtonFormField<int?>(
                value: docenteId,
                items: [
                  const DropdownMenuItem<int?>(
                    value: null,
                    child: Text('Sin docente'),
                  ),
                  ...docentes.map(
                    (d) => DropdownMenuItem<int?>(
                      value: d.id,
                      child: Text('${d.nombres} ${d.apellidos}'),
                    ),
                  ),
                ],
                onChanged: (v) => docenteId = v,
                decoration: const InputDecoration(labelText: 'Docente'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: capacidad,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Capacidad'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: anio,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Año'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: periodo,
                items: const [
                  DropdownMenuItem(
                    value: '01',
                    child: Text('01 (Primer semestre)'),
                  ),
                  DropdownMenuItem(
                    value: '02',
                    child: Text('02 (Segundo semestre)'),
                  ),
                ],
                onChanged: (v) => periodo = v ?? '01',
                decoration: const InputDecoration(labelText: 'Periodo'),
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
              if (asignaturaId == null) return;
              final g = Grupo(
                id: edit?.id,
                asignaturaId: asignaturaId!,
                docenteId: docenteId,
                capacidad: int.tryParse(capacidad.text.trim()) ?? 0,
                anio: int.tryParse(anio.text.trim()) ?? DateTime.now().year,
                periodo: periodo,
              );
              if (edit == null) {
                await vm.add(g);
              } else {
                await vm.update(g);
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
