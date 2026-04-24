import '../models/accidente_model.dart';

class AccidenteIsolate {
  static Map<String, dynamic> procesarDatos(List<dynamic> rawData) {
    final stopwatch = Stopwatch()..start();
    print("[Isolate] Iniciado — ${rawData.length} registros recibidos");

    Map<String, double> clases = {};
    Map<String, double> gravedad = {};
    Map<String, int> barrios = {};
    Map<String, double> dias = {};

    for (var item in rawData) {
      final acc = Accidente.fromJson(item);
      clases[acc.clase] = (clases[acc.clase] ?? 0) + 1;
      gravedad[acc.gravedad] = (gravedad[acc.gravedad] ?? 0) + 1;
      barrios[acc.barrio] = (barrios[acc.barrio] ?? 0) + 1;
      dias[acc.dia] = (dias[acc.dia] ?? 0) + 1;
    }

    var topBarrios =
        (barrios.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
            .take(5)
            .toList();

    stopwatch.stop();
    print("[Isolate] Completado en ${stopwatch.elapsedMilliseconds} ms");

    return {
      'clases': clases,
      'gravedad': gravedad,
      'barrios': Map.fromEntries(topBarrios),
      'dias': dias,
    };
  }
}
