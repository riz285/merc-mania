// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final orderCollectionRef = FirebaseFirestore.instance.collection('orders');


/// Create new Order
  Future<void> createOrder(Map<String, dynamic> data) async {
    try {
      await orderCollectionRef.add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }
  
  /// Get User's Order list
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserOrders(String userId) {
    return orderCollectionRef.where('user_id', isEqualTo: userId).snapshots();
  }


}