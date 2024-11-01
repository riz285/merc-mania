part of 'order_cubit.dart';

enum Status {
  initial,
  inProgress,
  success,
  failure,
}

final class OrderState extends Equatable {
  const OrderState({
    required this.orders,
    required this.quantity,
    required this.total,
    this.createdAt,
    this.paymentMethod,
    this.status = Status.initial,
  });

  final List<UserOrder> orders;
  final int quantity;
  final int total;
  final String? createdAt;
  final PaymentMethod? paymentMethod;
  final Status status;

  @override
  List<Object?> get props => [
        orders,
        quantity,
        total,
        createdAt,
        paymentMethod
      ];

  OrderState copyWith({
    List<UserOrder>? orders,
    int? quantity, 
    int? total,
    String? createdAt,
    PaymentMethod? paymentMethod,
    Status? status
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      quantity: quantity ?? this.orders.length,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status
    );
  }
}