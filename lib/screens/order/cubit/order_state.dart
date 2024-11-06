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
    this.order,
    this.quantity,
    this.total,
    this.createdAt,
    this.address,
    this.paymentMethod,
    this.status = Status.initial,
  });

  final List<AppOrder> orders;
  final AppOrder? order;
  final int? quantity;
  final int? total;
  final String? createdAt;
  final Address? address;
  final PaymentMethod? paymentMethod;
  final Status status;

  @override
  List<Object?> get props => [
        orders,
        order,
        quantity,
        total,
        createdAt,
        address,
        paymentMethod,
        status
      ];

  OrderState copyWith({
    List<AppOrder>? orders,
    AppOrder? order,
    int? quantity, 
    int? total,
    String? createdAt,
    Address? address,
    PaymentMethod? paymentMethod,
    Status? status
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      order: order ?? this.order,
      quantity: quantity ?? this.orders.length,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status
    );
  }
}