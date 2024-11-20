part of 'order_cubit.dart';

final class OrderState extends Equatable {
  const OrderState({
    this.orderId,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage
  });

  final String? orderId;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        status
      ];

  OrderState copyWith({
    String? orderId,
    FormzSubmissionStatus? status,
    String? errorMessage
  }) {
    return OrderState(
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}