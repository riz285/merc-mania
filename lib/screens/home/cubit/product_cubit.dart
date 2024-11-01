import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../../services/models/product.dart';

part 'product_state.dart';

class ProductCubit extends HydratedCubit<ProductState> {
  ProductCubit(this._authenticationRepository) : super(const ProductState(recentlyViewedProducts: []));

  final AuthenticationRepository _authenticationRepository;
  final productService = ProductService();

  /// Increase view
  Future<void> increaseView(Product product) async {
    final productId = product.id;
    final viewCount = product.viewCount ?? 0;
    productService.increaseView(productId, {'view_count': viewCount + 1});
  }

  /// Add product ids to Recently Viewed List 
  void addToRecentList(String productId) {
    final updatedList = state.recentlyViewedProducts.toList();
    if (updatedList.isNotEmpty) updatedList.remove(productId); // remove duplicate
    if (updatedList.length >= 8) updatedList.removeLast();
    updatedList.insert(0, productId); // add to headList
    emit(
      state.copyWith(
         recentlyViewedProducts: updatedList.toList()
      )
    );
  }

  /// Clear Recently Viewed Product List
  void clearProduct() {
    emit(
      state.copyWith(
         recentlyViewedProducts: []
      )
    );
  }

  @override
  ProductState? fromJson(Map<String, dynamic> json) {
    return ProductState(
      recentlyViewedProducts: json['recently_viewed'] as List<String>, 
    );
  }
  
  @override
  Map<String, dynamic>? toJson(ProductState state) {
    return{
    'recently_viewed' : state.recentlyViewedProducts, 
    };
  }                          
}