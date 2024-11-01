import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../../services/models/product.dart';
import '../../../services/models/order.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit(this._authenticationRepository) : super(const CartState(products: [], quantity: 0, total: 0));

  final AuthenticationRepository _authenticationRepository;
  final productService = ProductService();

  /// Add Product to Cart 
  void addToCart(Product product) {
    final updatedList = state.products.toList();
    if (updatedList.isNotEmpty) updatedList.remove(product);
    updatedList.insert(0, product); // add to headList
    // if (updatedList.length >= 50)
    emit(
      state.copyWith(
         products: updatedList.toList(),
         total: state.total + product.price,
         quantity: updatedList.length
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
  
  /// Empty Cart
  void resetCart() {
    List<Product> updatedList = List.empty();
    emit(
      state.copyWith(
        products: updatedList,
        total: 0
      ));
  }


  List<Product> productsFromJson(List<dynamic> json) {
    return json.map((e) => Product.fromJson(e)).toList();
  }

  List<dynamic> productsToJson(List<Product> products) {
    return products.map((e) => e.toJson()).toList();
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
    );
  }
  
  @override
  Map<String, dynamic>? toJson(CartState state) {
    return {
      'products' : productsToJson(state.products),
      'quantity' : state.quantity,
      'total' : state.total,
    };
  }

  void checkOutCart() {
      emit(state.copyWith(status: Status.inProgress));
    try {
      resetCart();  
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