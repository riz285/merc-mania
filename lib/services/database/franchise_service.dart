// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';


class FranchiseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final franchiseCollectionRef = FirebaseFirestore.instance.collection('franchise');

// CRUD
  // Add new Franchise
  Future<void> addFranchise(Map<String, dynamic> data) async {
    try {
      await franchiseCollectionRef.add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }

  /// Get all Franchise
  Stream<QuerySnapshot<Map<String, dynamic>>> getFranchise() {
    return franchiseCollectionRef.snapshots();
  }

  // Update Franchise data
  Future<void> updateFranchise(String id, Map<String, dynamic> data) async {
    try {
      await franchiseCollectionRef.doc(id).update(data);
      print('Data updated successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Delete Franchise
  Future<void> deleteFranchise(String id) async {
    try {
      await franchiseCollectionRef.doc(id).delete();
      print('Data deleted successfully');
    } catch (e) {
      print('$e');
    }
  }
}