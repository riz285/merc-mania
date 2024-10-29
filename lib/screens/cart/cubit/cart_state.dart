part of 'cart_cubit.dart';

enum Status {
  initial,
  inProgress,
  success,
  failure,
}

final class CartState extends Equatable {
  const CartState({
    required this.products,
    required this.quantity,
    required this.total,
    required this.orders,
    this.status = Status.initial,
  });

  final List<Product> products;
  final int quantity;
  final int total;
  final List<UserOrder> orders;
  final Status status;

  @override
  List<Object?> get props => [
        products,
        quantity,
        total,
        orders
      ];

  CartState copyWith({
    List<Product>? products,
    int? quantity, 
    int? total,
    List<UserOrder>? orders, 
    Status? status
  }) {
    return CartState(
      products: products ?? this.products,
      quantity: quantity ?? this.products.length,
      total: total ?? this.total,
      orders: orders ?? this.orders,
      status: status ?? this.status
    );
  }
}