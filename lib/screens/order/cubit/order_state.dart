part of 'order_cubit.dart';

final class OrderState extends Equatable {
  const OrderState({
    required this.orders,
    this.order,
    this.quantity,
    this.total,
    this.createdAt,
    this.address,
    required this.paymentMethod,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage
  });

  final List<AppOrder> orders;
  final AppOrder? order;
  final int? quantity;
  final int? total;
  final String? createdAt;
  final Address? address;
  final int paymentMethod;
  final FormzSubmissionStatus status;
  final String? errorMessage;

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
    int? paymentMethod,
    FormzSubmissionStatus? status,
    String? errorMessage
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      order: order ?? this.order,
      quantity: quantity ?? this.orders.length,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}