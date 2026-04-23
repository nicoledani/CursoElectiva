import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../models/establecimiento_model.dart';
import '../../services/api_service.dart';

class EstablecimientosListView extends StatefulWidget {
  const EstablecimientosListView({super.key});

  @override
  State<EstablecimientosListView> createState() => _EstablecimientosListViewState();
}

class _EstablecimientosListViewState extends State<EstablecimientosListView> {
  final ApiService _apiService = ApiService();
  List<Establecimiento> _locales = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final data = await _apiService.fetchEstablecimientos();
    setState(() {
      _locales = data;
      _loading = false;
    });
  }

  Future<void> _confirmDelete(int id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("¿Eliminar?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("NO")),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("SÍ")),
        ],
      ),
    );
    if (ok == true) {
      await _apiService.deleteEstablecimiento(id);
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Establecimientos")),
      body: Skeletonizer(
        enabled: _loading,
        child: ListView.builder(
          itemCount: _locales.length,
          itemBuilder: (context, index) {
            final e = _locales[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: e.logo != null ? NetworkImage(e.logo!) : null,
                  child: e.logo == null ? const Icon(Icons.business) : null,
                ),
                title: Text(e.nombre),
                subtitle: Text("NIT: ${e.nit}"),
                onTap: () async {
                  final result = await context.push('/formulario', extra: e);
                  if (result == true) _load();
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(e.id!),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await context.push('/formulario');
          if (result == true) _load();
        },
      ),
    );
  }
}