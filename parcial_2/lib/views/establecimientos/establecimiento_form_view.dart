import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../models/establecimiento_model.dart';
import '../../services/api_service.dart';

class EstablecimientoFormView extends StatefulWidget {
  final Establecimiento? establecimiento;
  const EstablecimientoFormView({super.key, this.establecimiento});

  @override
  State<EstablecimientoFormView> createState() =>
      _EstablecimientoFormViewState();
}

class _EstablecimientoFormViewState extends State<EstablecimientoFormView> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

  late TextEditingController _nameCtrl, _nitCtrl, _dirCtrl, _telCtrl;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.establecimiento?.nombre);
    _nitCtrl = TextEditingController(text: widget.establecimiento?.nit);
    _dirCtrl = TextEditingController(text: widget.establecimiento?.direccion);
    _telCtrl = TextEditingController(text: widget.establecimiento?.telefono);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final formData = FormData.fromMap({
      'nombre': _nameCtrl.text,
      'nit': _nitCtrl.text,
      'direccion': _dirCtrl.text,
      'telefono': _telCtrl.text,
      if (_selectedImage != null)
        'logo': await MultipartFile.fromFile(_selectedImage!.path),
    });

    try {
      if (widget.establecimiento == null) {
        await _apiService.createEstablecimiento(formData);
      } else {
        await _apiService.updateEstablecimiento(
          widget.establecimiento!.id!,
          formData,
        );
      }
      if (mounted) context.pop(true);
    } catch (e) {
      debugPrint("Error guardando: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.establecimiento == null ? "Nuevo" : "Editar"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextFormField(
              controller: _nitCtrl,
              decoration: const InputDecoration(labelText: "NIT"),
            ),
            TextFormField(
              controller: _dirCtrl,
              decoration: const InputDecoration(labelText: "Dirección"),
            ),
            TextFormField(
              controller: _telCtrl,
              decoration: const InputDecoration(labelText: "Teléfono"),
            ),
            const SizedBox(height: 20),
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 100)
                : (widget.establecimiento?.logo != null
                      ? Image.network(
                          widget.establecimiento!.logo!,
                          height: 100,
                        )
                      : const Icon(Icons.image, size: 100)),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Seleccionar Logo"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _save,
              child: const Text("Guardar Establecimiento"),
            ),
          ],
        ),
      ),
    );
  }
}
