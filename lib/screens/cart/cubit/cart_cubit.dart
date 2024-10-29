import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../../services/models/product.dart';
import '../../../services/models/order.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit(this._authenticationRepository) : super(const CartState(products: [], quantity: 0, total: 0, orders: []));

  final AuthenticationRepository _authenticationRepository;
  final productService = ProductService();

  /// Add Product to Cart 
  void addToCart(Product product) {
    List<Product> updatedList = state.products.toList();
    if (updatedList.isNotEmpty) updatedList.remove(product);
    updatedList.insert(0, product); // add to headList
    // if (updatedList.length >= 50)
    emit(
      state.copyWith(
         products: updatedList.toList(),
         total: state.total + product.price,
      )
    );
  }

  /// Remove Product from Cart
  void removeFromCart(Product product) {
    final updatedList = state.products.toList();
    updatedList.remove(product); // 
    emit(
      state.copyWith(
         products: updatedList.toList(),
         total: state.total - product.price
      )
    );
  }
  

  List<Product> productsFromJson(List<dynamic> json) {
    return json.map((e) => Product.fromJson(e)).toList();
  }

  List<dynamic> productsToJson(List<Product> products) {
    return products.map((e) => e.toFirestore()).toList();
  }

  List<UserOrder> ordersFromJson(List<dynamic> json) {
    return json.map((e) => UserOrder.fromJson(e)).toList();
  }

  List<dynamic> ordersToJson(List<UserOrder> orders) {
    return orders.map((e) => e.toFirestore()).toList();
  }
  
  @override
  CartState? fromJson(Map<String, dynamic> json) {
    
    return CartState(
      products: productsFromJson(json['products']), 
      quantity: json['quantity'] as int, 
      total: json['total'] as int, 
      orders:  ordersFromJson(json['orders'])
    );
  }
  
  @override
  Map<String, dynamic>? toJson(CartState state) {
    return {
      'products' : productsToJson(state.products),
      'quantity' : state.quantity,
      'total' : state.total,
      'orders' : ordersToJson(state.orders)
    };
  }

  /// Create new Order
  void addNewOrder(UserOrder order) {
    List<UserOrder> updatedList = state.orders.toList();
    updatedList.insert(0, order); // add to headList
    // if (updatedList.length >= 8)
    emit(
      state.copyWith(
         orders: updatedList,
         products: [],
         total: 0
      )
    );
  }

  /// Remove order
  // void removeOrder(Product product) {
  //   final updatedList = state.products.toList();
  //   updatedList.remove(product); // 
  //   emit(
  //     state.copyWith(
  //        products: updatedList,
  //        total: state.total - product.price
  //     )
  //   );
  // }
  
  void checkOutCart() {
      emit(state.copyWith(status: Status.inProgress));
    try {
      if (state.products.isNotEmpty) {
        UserOrder order = UserOrder(
          id: AppFormat.dateTostring.format(DateTime.now()), 
          products: state.products, 
          createdAt: AppFormat.date.format(DateTime.now()),
          total: state.total,
          userId: _authenticationRepository.currentUser.id
        );
        addNewOrder(order);
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