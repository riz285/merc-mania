import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/services/database/order_service.dart';

import '../../../services/models/order.dart';
import '../../../services/models/payment.dart';

part 'order_state.dart';

class OrderCubit extends HydratedCubit<OrderState> {
  OrderCubit(this._authenticationRepository) : super(const OrderState(orders: [], quantity: 0, total: 0));

  final AuthenticationRepository _authenticationRepository;
  final orderService = ProductService();

  /// Create new Order
  void addOrder(UserOrder order) { //
    List<UserOrder> updatedList = state.orders.toList();
      updatedList.insert(0, order); // add to headList
      emit(
        state.copyWith(
          orders: updatedList.toList(),
        )
      ); // add to headList
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

  List<UserOrder> ordersFromJson(List<dynamic> json) {
    return json.map((e) => UserOrder.fromJson(e)).toList();
  }

  List<dynamic> ordersToJson(List<UserOrder> orders) {
    return orders.map((e) => e.toFirestore()).toList();
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

  
  
  void checkOutOrder() {
      emit(state.copyWith(status: Status.inProgress));
    try {
      if (state.orders.isNotEmpty) {
        UserOrder order = UserOrder(
          id: AppFormat.dateTostring.format(DateTime.now()), 
          createdAt: AppFormat.date.format(DateTime.now()),
          total: state.total,
          userId: _authenticationRepository.currentUser.id
        );
        addOrder(order);
      }
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