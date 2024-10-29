import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'product.dart';

class UserOrder extends Equatable {
  const UserOrder({
    required this.id,
    this.userId,
    this.products,
    this.createdAt,
    this.total
  });

  final String id;
  final String? userId;
  final List<Product>? products;
  final String? createdAt;
  final int? total;

  static const empty = UserOrder(id: '');

  factory UserOrder.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return UserOrder(
      id: data['id'],
      userId: data['user_id'],
      products: data['products'],
      createdAt: data['created_at'],
      total: data['total']
      );
  }

  factory UserOrder.fromJson(Map<String, dynamic> json) {
    return UserOrder(
      id: json['id'],
      userId: json['user_id'],
      products: json['products'],
      createdAt: json['created_at'],
      total: json['total']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      'user-id' : userId,
      'products' : products,
      'created_at' : createdAt,
      'total' : total,
    };
  }

  @override
  List<Object?> get props => [id, userId, createdAt, total];
}