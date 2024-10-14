import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.id,
    this.name,
    this.quantity,
  });

  final String id;
  final String? name;
  final String? quantity;

  static const empty = CartItem(id: '');

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      quantity: json['photo']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name,
      'quantity': quantity
    };
  }

  @override
  List<Object?> get props => [id, name, quantity];
}