// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final collectionRef = FirebaseFirestore.instance.collection('');


// CRUD
  // Add data
  Future<void> addData(String collectionName, Map<String, dynamic> data) async {
    try {
      await firestore.collection(collectionName).add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Retrieve data
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getData(String collectionName) async {
    try {
      return firestore.collection(collectionName).snapshots();
    } catch (e) {
      print('$e');
      return Stream.empty();
    }
  }

  // Update data


  // Deleta data
  Future<void> deleteData(String collectionName, String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
      print('Data deleted successfully');
    } catch (e) {
      print('$e');
    }
  }
}