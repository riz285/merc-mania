import 'package:equatable/equatable.dart';

class AppOrder extends Equatable {
  const AppOrder({
    this.id,
    required this.userId,
    required this.productIds, // Item List
    required this.quantity,
    required this.total,
    required this.createdAt,
    this.shippingAddress,
    required this.paymentMethod
  });

  final String? id;
  final String userId;
  final List<String> productIds;
  final int quantity;
  final int total;
  final String createdAt;
  final String? shippingAddress;
  final String paymentMethod;

  static const empty = AppOrder(userId: '', productIds: [], quantity: 0, total: 0, createdAt: '01-01-1900 00:00', paymentMethod: '');

  factory AppOrder.fromJson(Map<String, dynamic> json) {
    return AppOrder(
      id: json['id'],
      userId: json['user_id'],
      productIds: List<String>.from(json['products']),
      quantity: json['quantity'],
      total: json['total'],
      createdAt: json['created_at'],
      shippingAddress: json['shipping_address'],
      paymentMethod: json['payment_method']
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'user_id' : userId,
      'products' : productIds,
      'quantity' : quantity,
      'total' : total,
      'created_at' : createdAt,
      'shipping_address' : shippingAddress,
      'payment_method' : paymentMethod
    };
  }

  @override
  List<Object?> get props => [id, userId, productIds, quantity, total, createdAt, shippingAddress, paymentMethod];
}