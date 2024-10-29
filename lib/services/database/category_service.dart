// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';


class CategoryService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final categoryCollectionRef = FirebaseFirestore.instance.collection('categories');

// CRUD
  // Add category
  Future<void> addCategory(Map<String, dynamic> data) async {
    try {
      await categoryCollectionRef.add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }

  /// Get all categories
  Stream<QuerySnapshot<Map<String, dynamic>>> getCategories() {
    return categoryCollectionRef.snapshots();
  }

  /// Get all categories from Games, Toys, Merchandise
  Stream<QuerySnapshot<Map<String, dynamic>>> getSubCat01() {
    return categoryCollectionRef.doc('6Iw59orGRofhGhOriZ9n').collection('sub-categories').where('id', isEqualTo: '6TscsVpS5uVob9r28hVw').snapshots();
  }

  // Update category data
  Future<void> updateCategory(Map<String, dynamic> data) async {
    try {
      await categoryCollectionRef.doc(data['id']).update(data);
      print('Data updated successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Deleta category
  Future<void> deleteCategory(String id) async {
    try {
      await categoryCollectionRef.doc(id).delete();
      print('Data deleted successfully');
    } catch (e) {
      print('$e');
    }
  }
}