// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';


class FranchiseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final franchiseCollectionRef = FirebaseFirestore.instance.collection('franchise');

// CRUD
  // Add franchise
  Future<void> addFranchise(Map<String, dynamic> data) async {
    try {
      await franchiseCollectionRef.add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }

  /// Get all franchise
  Stream<QuerySnapshot<Map<String, dynamic>>> getFranchise() {
    return franchiseCollectionRef.snapshots();
  }

  // Update franchise data
  Future<void> updateFranchise(Map<String, dynamic> data) async {
    try {
      await franchiseCollectionRef.doc(data['id']).update(data);
      print('Data updated successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Deleta franchise
  Future<void> deleteFranchise(String id) async {
    try {
      await franchiseCollectionRef.doc(id).delete();
      print('Data deleted successfully');
    } catch (e) {
      print('$e');
    }
  }
}