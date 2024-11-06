part of 'cart_cubit.dart';

final class CartState extends Equatable {
  const CartState({
    required this.products,
    this.quantity = 0,
    this.total = 0,
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final List<Product> products;
  final int quantity;
  final int total;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props => [
        products,
        quantity,
        total,
        isValid,
        status
      ];

  CartState copyWith({
    List<Product>? products,
    int? quantity, 
    int? total,
    bool? isValid,
    FormzSubmissionStatus? status
  }) {
    return CartState(
      products: products ?? this.products,
      quantity: quantity ?? this.products.length,
      total: total ?? this.total,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status
    );
  }
}