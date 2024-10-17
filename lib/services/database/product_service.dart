// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';


class ProductService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final productCollectionRef = FirebaseFirestore.instance.collection('products');
  final popularProductRef = FirebaseFirestore
      .instance
      .collection('products')
      .where('categoryId', isEqualTo: '');

// CRUD
  // Add product
  Future<void> addProduct(Map<String, dynamic> data) async {
    try {
      await productCollectionRef.add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Retrieve product
  // Future<List<Product>> getProductList() async {
  //     final querySnapshot = await productCollectionRef.get();
  //     return querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return productCollectionRef.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPopularProduct() {
    return popularProductRef.snapshots();
  }

  // Update product data
  Future<void> updateProduct(Map<String, dynamic> data) async {
    try {
      await productCollectionRef.doc(data['id']).update(data);
      print('Data updated successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Deleta product
  Future<void> deleteProduct(String id) async {
    try {
      await productCollectionRef.doc(id).delete();
      print('Data deleted successfully');
    } catch (e) {
      print('$e');
    }
  }
}