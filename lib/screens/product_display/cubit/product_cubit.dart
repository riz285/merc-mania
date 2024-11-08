import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../../services/models/product.dart';

part 'product_state.dart';

class ProductCubit extends HydratedCubit<ProductState> {
  ProductCubit(this._authenticationRepository) : super(const ProductState(recentlyViewedProducts: [], favoriteProducts: []));

  final AuthenticationRepository _authenticationRepository;
  final productService = ProductService();

  /// Increase Product's view count
  Future<void> increaseView(Product product) async {
    final productId = product.id;
    final viewCount = product.viewCount ?? 0;
    productService.increaseView(productId, {'view_count': viewCount + 1});
  }

  bool isFavorite(String productId) {
    final updatedList = state.favoriteProducts.toList();
    if (updatedList.contains(productId)) return true;
    return false;
  }

  void toggleFavorite(String productId) {
    if (!isFavorite(productId)) {
      addToWishList(productId);
      print('Successfully added to wishlist');
    } else {
      removeFromWishList(productId);
      print('Removed from wishlist');
    }
  }

  /// Add Product's id to Recently Viewed List 
  void addToWishList(String productId) {
    final updatedList = state.favoriteProducts.toList();
    updatedList.insert(0, productId); // add to headList
    emit(
      state.copyWith(
         favoriteProducts: updatedList.toList()
      )
    );
  }

  void removeFromWishList(String productId) {
    final updatedList = state.favoriteProducts.toList();
    updatedList.remove(productId);
    emit(
      state.copyWith(
         favoriteProducts: updatedList.toList()
      )
    );
  }

  /// Add Product's id to Recently Viewed List 
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
  void clearRecentList() {
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
      favoriteProducts: json['wish_list'] as List<String>, 
    );
  }
  
  @override
  Map<String, dynamic>? toJson(ProductState state) {
    return{
    'recently_viewed' : state.recentlyViewedProducts, 
    'wish_list' : state.favoriteProducts
    };
  }                          
}