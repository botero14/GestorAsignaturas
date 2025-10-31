import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/matriculas_vm.dart';

class MatriculasPage extends StatefulWidget {
  final int grupoId;
  final String? titulo; // opcional para el AppBar

  const MatriculasPage({super.key, required this.grupoId, this.titulo});

  @override
  State<MatriculasPage> createState() => _MatriculasPageState();
}

class _MatriculasPageState extends State<MatriculasPage> {
  int? _selectedEstId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MatriculasVM>().load(widget.grupoId));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MatriculasVM>();
    final cs = Theme.of(context).colorScheme;

    final tituloApp =
        widget.titulo ??
        (vm.asignatura != null
            ? 'Matrículas • ${vm.asignatura!.nombre}'
            : 'Matrículas del grupo ${widget.grupoId}');

    return Scaffold(
      appBar: AppBar(
        title: Text(tituloApp),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Cabecera con capacidad
                  if (vm.grupo != null) ...[
                    Row(
                      children: [
                        Text(
                          'Año/Periodo: ${vm.grupo!.anio}-${vm.grupo!.periodo}',
                        ),
                        const SizedBox(width: 16),
                        Text('Capacidad: ${vm.grupo!.capacidad}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Línea de alta (dropdown + botón)
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _selectedEstId,
                          items: vm.noMatriculados
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text('${e.nombres} ${e.apellidos}'),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _selectedEstId = v),
                          decoration: const InputDecoration(
                            labelText: 'Estudiante a matricular',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.icon(
                        onPressed: (_selectedEstId == null)
                            ? null
                            : () async {
                                final ok = await vm.add(_selectedEstId!);
                                if (!ok && vm.lastError != null) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(vm.lastError!)),
                                    );
                                  }
                                } else {
                                  setState(() => _selectedEstId = null);
                                }
                              },
                        icon: const Icon(Icons.person_add_alt_1),
                        label: const Text('Matricular'),
                      ),
                    ],
                  ),

                  if (vm.lastError != null) ...[
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        vm.lastError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  const Divider(),

                  // Listado
                  Expanded(
                    child: ListView.separated(
                      itemCount: vm.items.length,
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemBuilder: (_, i) {
                        final m = vm.items[i];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(vm.nombreEstudiante(m.estudianteId)),
                          subtitle: Text('Inscrito: ${m.fechaIso}'),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.person_remove_alt_1_outlined,
                              color: Colors.red,
                            ),
                            onPressed: () => vm.remove(m.estudianteId),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
