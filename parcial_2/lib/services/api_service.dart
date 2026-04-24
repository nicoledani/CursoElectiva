import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/establecimiento_model.dart';
import 'package:flutter/foundation.dart'; 

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        if (!kIsWeb)
          'User-Agent':
              'Mozilla/5.0 (Android 13; Mobile; rv:110.0) Gecko/110.0 Firefox/110.0',
        'Accept': 'application/json',
      },
    ),
  );

  final String _urlAccidentes = dotenv.env['API_ACCIDENTES'] ?? '';
  final String _urlParqueadero = dotenv.env['API_PARQUEADERO'] ?? '';

  Future<List<dynamic>> fetchAccidentes() async {
    try {
      final response = await _dio.get('$_urlAccidentes?\$limit=100000');
      return response.data as List<dynamic>;
    } catch (e) {
      throw Exception('Error al obtener accidentes: $e');
    }
  }

  Future<List<Establecimiento>> fetchEstablecimientos() async {
    try {
      final response = await _dio.get(
        'https://parking.visiontic.com.co/api/establecimientos',
      );
      final List<dynamic> listaJson = response.data['data'];

      return listaJson.map((json) => Establecimiento.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener establecimientos: $e');
    }
  }

  Future<void> createEstablecimiento(FormData data) async {
    try {
      await _dio.post('$_urlParqueadero/establecimientos', data: data);
    } catch (e) {
      throw Exception('Error al crear establecimiento: $e');
    }
  }

  Future<void> updateEstablecimiento(int id, FormData data) async {
    try {
      data.fields.add(MapEntry('_method', 'PUT'));
      await _dio.post(
        '$_urlParqueadero/establecimiento-update/$id',
        data: data,
      );
    } catch (e) {
      throw Exception('Error al actualizar establecimiento: $e');
    }
  }

  Future<void> deleteEstablecimiento(int id) async {
    try {
      await _dio.delete('$_urlParqueadero/establecimientos/$id');
    } catch (e) {
      throw Exception('Error al eliminar establecimiento: $e');
    }
  }
}
