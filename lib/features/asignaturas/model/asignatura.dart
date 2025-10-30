class Asignatura {
  final int? id;
  final int pensumId; // se relacionará con Pensum más adelante
  final String nombre;
  final int creditos;
  final String
  area; // "Ciencias basicas", "Ciencias basicas Ingenieria", "Basico profesional", "Sociohumanistico"
  final bool habilitable; // true/false
  final int semestre; // 1..10
  final String codigo; // único
  final int horasSemana;

  const Asignatura({
    this.id,
    required this.pensumId,
    required this.nombre,
    required this.creditos,
    required this.area,
    required this.habilitable,
    required this.semestre,
    required this.codigo,
    required this.horasSemana,
  });

  Asignatura copyWith({
    int? id,
    int? pensumId,
    String? nombre,
    int? creditos,
    String? area,
    bool? habilitable,
    int? semestre,
    String? codigo,
    int? horasSemana,
  }) {
    return Asignatura(
      id: id ?? this.id,
      pensumId: pensumId ?? this.pensumId,
      nombre: nombre ?? this.nombre,
      creditos: creditos ?? this.creditos,
      area: area ?? this.area,
      habilitable: habilitable ?? this.habilitable,
      semestre: semestre ?? this.semestre,
      codigo: codigo ?? this.codigo,
      horasSemana: horasSemana ?? this.horasSemana,
    );
  }
}
