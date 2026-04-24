import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../services/api_service.dart';
import '../../isolates/accidente_isolate.dart';
import 'package:flutter/foundation.dart'; // <--- AGREGAR ESTO

class AccidentesView extends StatefulWidget {
  const AccidentesView({super.key});

  @override
  State<AccidentesView> createState() => _AccidentesViewState();
}

class _AccidentesViewState extends State<AccidentesView> {
  final ApiService _apiService = ApiService();
  bool _loading = true;
  Map<String, dynamic> _stats = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final rawData = await _apiService.fetchAccidentes();

      Map<String, dynamic> results;

      if (kIsWeb) {
        // EN WEB: Ejecutamos el procesamiento de forma asíncrona normal
        // Usamos Future.value o simplemente llamamos a la función
        // ya que dart:isolate no está disponible.
        results = await Future(() => AccidenteIsolate.procesarDatos(rawData));
      } else {
        // EN MÓVIL/DESKTOP: Usamos compute (que usa Isolates internamente)
        // Es más seguro y limpio para compatibilidad.
        results = await compute(AccidenteIsolate.procesarDatos, rawData);
      }

      if (mounted) {
        setState(() {
          _stats = results;
          _loading = false;
        });
      }
    } catch (e) {
      debugPrint("Error cargando accidentes: $e");
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Estadísticas Accidentes Tuluá")),
      body: Skeletonizer(
        enabled: _loading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildChartCard(
                "Clase de Accidente",
                _buildPieChart(_stats['clases']),
              ),
              _buildChartCard("Gravedad", _buildBarChart(_stats['gravedad'])),
              _buildChartCard(
                "Top 5 Barrios",
                _buildBarChart(_stats['barrios']),
              ),
              _buildChartCard(
                "Día de la Semana",
                _buildPieChart(_stats['dias']),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(height: 200, child: chart),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(Map<String, dynamic>? data) {
    if (data == null) return const SizedBox();
    return PieChart(
      PieChartData(
        sections: data.entries
            .map(
              (e) => PieChartSectionData(
                value: e.value.toDouble(),
                title: e.key,
                radius: 50,
                titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBarChart(Map<String, dynamic>? data) {
    if (data == null) return const SizedBox();
    return BarChart(
      BarChartData(
        barGroups: data.entries.indexed
            .map(
              (e) => BarChartGroupData(
                x: e.$1,
                barRods: [
                  BarChartRodData(
                    toY: e.$2.value.toDouble(),
                    color: Colors.blue,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
