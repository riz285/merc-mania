part of 'cart_cubit.dart';

final class CartState extends Equatable {
  const CartState({
    required this.products,
    this.quantity = 0,
    this.total = 0,
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.product,
    this.price,
  });

  final List<Product> products;
  final int quantity;
  final int total;
  final bool isValid;
  final FormzSubmissionStatus status;
  final List<Product>? product;
  final int? price;

  @override
  List<Object?> get props => [
        products,
        quantity,
        total,
        isValid,
        status, 
        product,
        price
      ];

  CartState copyWith({
    List<Product>? products,
    int? quantity, 
    int? total,
    bool? isValid,
    FormzSubmissionStatus? status, 
    List<Product>? product,
    int? price
  }) {
    return CartState(
      products: products ?? this.products,
      quantity: quantity ?? this.products.length,
      total: total ?? this.total,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      product: product ?? this.product,
      price: price ?? price
    );
  }
}