import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/services/database/order_service.dart';
import 'package:merc_mania/services/models/product.dart';

import '../../../services/models/address.dart';
import '../../../services/models/order.dart';
import '../../../services/models/payment.dart';

part 'order_state.dart';

class OrderCubit extends HydratedCubit<OrderState> {
  OrderCubit(this._authenticationRepository) : super(const OrderState(orders: [], quantity: 0, total: 0));

  final AuthenticationRepository _authenticationRepository;
  final orderService = OrderService();

  void createNewOrder(List<Product> items, int total, Address address) {
    final List<String> productIds = items.map((product) => product.id).toList();
    final String shippingAddress = address.ward! + address.street! + address.detail!;
    final AppOrder order = AppOrder(
          productIds: productIds,
          quantity: items.length,
          total: total,
          createdAt: AppFormat.date.format(DateTime.now()),
          shippingAddress: shippingAddress,
          userId: _authenticationRepository.currentUser.id
          );
    orderService.createOrder(order.toJson()); // Add new order to database
    emit(
      state.copyWith(
        order: order
      )
    );
  }

  /// Remove order
  // void removeOrder(Product order) {
  //   final updatedList = state.orders.toList();
  //   updatedList.remove(order); // 
  //   emit(
  //     state.copyWith(
  //        orders: updatedList,
  //        total: state.total - order.price
  //     )
  //   );
  // }

  List<AppOrder> ordersFromJson(List<dynamic> json) {
    return json.map((e) => AppOrder.fromJson(e)).toList();
  }

  List<dynamic> ordersToJson(List<AppOrder> orders) {
    return orders.map((e) => e.toJson()).toList();
  }
  
  @override
  OrderState? fromJson(Map<String, dynamic> json) {
    
    return OrderState(
      orders: ordersFromJson(json['orders']), 
      quantity: json['quantity'] as int, 
      total: json['total'] as int, 
    );
  }
  
  @override
  Map<String, dynamic>? toJson(OrderState state) {
    return {
      'orders' : ordersToJson(state.orders),
      'quantity' : state.quantity,
      'total' : state.total,
    };
  }  
  
  void checkOutOrder(List<Product> items, int total, Address address) {
      emit(state.copyWith(status: Status.inProgress));
    try {
      createNewOrder(items, total, address);
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
    }
  }
}