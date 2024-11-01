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
    this.status = Status.initial,
  });

  final List<Product> products;
  final int quantity;
  final int total;
  final Status status;

  @override
  List<Object?> get props => [
        products,
        quantity,
        total
      ];

  CartState copyWith({
    List<Product>? products,
    int? quantity, 
    int? total,
    Status? status
  }) {
    return CartState(
      products: products ?? this.products,
      quantity: quantity ?? this.products.length,
      total: total ?? this.total,
      status: status ?? this.status
    );
  }
}