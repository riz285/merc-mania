import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'product.dart';

class UserOrder extends Equatable {
  const UserOrder({
    required this.id,
    this.userId,
    this.products,
    this.quantity,
    this.total,
    this.createdAt,
  });

  final String id;
  final String? userId;
  final List<Product>? products;
  final int? quantity;
  final int? total;
  final String? createdAt;

  static const empty = UserOrder(id: '');

  factory UserOrder.fromJson(Map<String, dynamic> json) {
    return UserOrder(
      id: json['id'],
      userId: json['user_id'],
      products: json['products'],
      quantity: json['quantity'],
      total: json['total'],
      createdAt: json['created_at'],
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      'user-id' : userId,
      'products' : products,
      'quantity' : quantity,
      'total' : total,
      'created_at' : createdAt,
    };
  }

  @override
  List<Object?> get props => [id, userId, quantity, total, createdAt];
}