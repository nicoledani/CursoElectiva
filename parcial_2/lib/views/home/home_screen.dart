import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  int _totalAccidentes = 0;
  int _totalEstablecimientos = 0;

  @override
  void initState() {
    super.initState();
    _fetchResumen();
  }

  Future<void> _fetchResumen() async {
    try {
      final accidentes = await _apiService.fetchAccidentes();
      final locales = await _apiService.fetchEstablecimientos();
      setState(() {
        _totalAccidentes = accidentes.length;
        _totalEstablecimientos = locales.length;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smart City Tuluá - Dashboard")),
      body: Skeletonizer(
        enabled: _isLoading,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatCard("Total Accidentes", "$_totalAccidentes", Icons.car_crash, Colors.orange),
              const SizedBox(height: 16),
              _buildStatCard("Establecimientos", "$_totalEstablecimientos", Icons.store, Colors.blue),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => context.push('/accidentes'),
                icon: const Icon(Icons.analytics),
                label: const Text("VER ESTADÍSTICAS"),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => context.push('/establecimientos'),
                icon: const Icon(Icons.edit_note),
                label: const Text("GESTIÓN DE ESTABLECIMIENTOS"),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }
}