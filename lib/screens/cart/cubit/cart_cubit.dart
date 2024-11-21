import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../../services/models/product.dart';
import '../../../services/models/order.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit() : super(const CartState(products: []));

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
         quantity: updatedList.length,
         isValid: true
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
         total: state.total - product.price,
         quantity: updatedList.length,
         isValid: updatedList.isNotEmpty
      )
    );
  }

  void addToPurchase(Product product) {
    final updatedList = <Product>[];
    updatedList.insert(0, product); // add to headList
    // if (updatedList.length >= 50)
    emit(
      state.copyWith(
         product: updatedList.toList(),
         price: product.price,
      )
    );
  }

  void deleteFromPurchase() {
    List<Product> updatedList = List.empty();
    emit(
      state.copyWith(
        product: updatedList,
        price: 0,
      ));
  }
  
  /// Empty Cart
  void resetCart() {
    List<Product> updatedList = List.empty();
    emit(
      state.copyWith(
        products: updatedList,
        total: 0,
        isValid: false
      ));
  }


  List<Product> productsFromJson(List<dynamic> json) {
    return json.map((e) => Product.fromJson(e)).toList();
  }

  List<dynamic> productsToJson(List<Product> products) {
    return products.map((e) => e.toJson()).toList();
  }

  List<AppOrder> ordersFromJson(List<dynamic> json) {
    return json.map((e) => AppOrder.fromJson(e)).toList();
  }

  List<dynamic> ordersToJson(List<AppOrder> orders) {
    return orders.map((e) => e.toJson()).toList();
  }
  
  @override
  CartState? fromJson(Map<String, dynamic> json) {
    
    return CartState(
      products: productsFromJson(json['products']), 
      quantity: json['quantity'] as int, 
      total: json['total'] as int, 
      isValid: json['not_empty'] as bool
    );
  }
  
  @override
  Map<String, dynamic>? toJson(CartState state) {
    return {
      'products' : productsToJson(state.products),
      'quantity' : state.quantity,
      'total' : state.total,
      'not_empty' : state.isValid
    };
  }

  void checkOutCart() {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    if (state.products.isNotEmpty) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
    else {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}
  
