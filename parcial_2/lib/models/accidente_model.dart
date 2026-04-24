class Accidente {
  final String clase;
  final String gravedad;
  final String barrio;
  final String dia;

  Accidente({
    required this.clase,
    required this.gravedad,
    required this.barrio,
    required this.dia,
  });

  factory Accidente.fromJson(Map<String, dynamic> json) {
    return Accidente(
      clase: json['clase_de_accidente'] ?? 'Otro',
      gravedad: json['gravedad_del_accidente'] ?? 'Solo daños',
      barrio: json['barrio_hecho'] ?? 'Desconocido',
      dia: json['dia'] ?? 'Sin dato',
    );
  }
}
