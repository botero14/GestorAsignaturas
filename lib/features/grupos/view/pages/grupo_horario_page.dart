import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/grupo_horario.dart';
import '../../viewmodel/grupo_horario_vm.dart';

class GrupoHorarioPage extends StatefulWidget {
  final int grupoId;
  final String? tituloGrupo; // opcional para mostrar en AppBar

  const GrupoHorarioPage({super.key, required this.grupoId, this.tituloGrupo});

  @override
  State<GrupoHorarioPage> createState() => _GrupoHorarioPageState();
}

class _GrupoHorarioPageState extends State<GrupoHorarioPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<GrupoHorarioVM>().load(widget.grupoId));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GrupoHorarioVM>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tituloGrupo ?? 'Horario del grupo ${widget.grupoId}',
        ),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, vm, widget.grupoId),
        child: const Icon(Icons.add),
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
                      final h = vm.items[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: cs.secondaryContainer,
                          child: Text(_diaCorto(h.diaSemana)),
                        ),
                        title: Text('${h.horaInicio} — ${h.horaFin}'),
                        subtitle: Text(_diaLargo(h.diaSemana)),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () =>
                                  _showForm(context, vm, h.grupoId, edit: h),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () => vm.remove(h.id!),
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

  String _diaCorto(int d) => const ['—', 'L', 'M', 'X', 'J', 'V', 'S', 'D'][d];
  String _diaLargo(int d) => const [
    '—',
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ][d];

  Future<void> _showForm(
    BuildContext context,
    GrupoHorarioVM vm,
    int grupoId, {
    GrupoHorario? edit,
  }) async {
    int dia = edit?.diaSemana ?? 1;
    final inicio = TextEditingController(text: edit?.horaInicio ?? '08:00');
    final fin = TextEditingController(text: edit?.horaFin ?? '10:00');
    String? errorMsg;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setS) => AlertDialog(
          title: Text(edit == null ? 'Nuevo tramo' : 'Editar tramo'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<int>(
                  value: dia,
                  items: List.generate(7, (i) => i + 1)
                      .map(
                        (d) => DropdownMenuItem(
                          value: d,
                          child: Text(_diaLargo(d)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => dia = v ?? 1,
                  decoration: const InputDecoration(
                    labelText: 'Día de la semana',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: inicio,
                  decoration: const InputDecoration(
                    labelText: 'Hora inicio (HH:MM)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: fin,
                  decoration: const InputDecoration(
                    labelText: 'Hora fin (HH:MM)',
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
                final h = GrupoHorario(
                  id: edit?.id,
                  grupoId: grupoId,
                  diaSemana: dia,
                  horaInicio: inicio.text.trim(),
                  horaFin: fin.text.trim(),
                );
                final ok = (edit == null)
                    ? await vm.add(h)
                    : await vm.update(h);
                if (!ok) {
                  setS(() => errorMsg = vm.lastError);
                  return;
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
