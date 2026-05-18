import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/universidad.dart';

class UniversidadService {
  static final _ref = FirebaseFirestore.instance.collection('universidades');

  static Stream<Universidad?> watchUniversidadById(String id) {
    return _ref.doc(id).snapshots().map((doc) {
      if (doc.exists) {
        return Universidad.fromMap(doc.id, doc.data()!);
      }
      return null;
    });
  }

  static Future<List<Universidad>> getUniversidades() async {
    final snapshot = await _ref.get();
    return snapshot.docs
        .map((doc) => Universidad.fromMap(doc.id, doc.data()))
        .toList();
  }

  static Future<void> addUniversidad(Universidad universidad) async {
    await _ref.add(universidad.toMap());
  }

  static Future<void> updateUniversidad(Universidad universidad) async {
    await _ref.doc(universidad.id).update(universidad.toMap());
  }

  static Future<Universidad?> getUniversidadById(String id) async {
    final doc = await _ref.doc(id).get();
    if (doc.exists) {
      return Universidad.fromMap(doc.id, doc.data()!);
    }
    return null;
  }

  static Future<void> deleteUniversidad(String id) async {
    await _ref.doc(id).delete();
  }

  static Stream<List<Universidad>> watchUniversidades() {
    return _ref.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Universidad.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}
