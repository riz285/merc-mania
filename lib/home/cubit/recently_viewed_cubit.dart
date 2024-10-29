import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';

part 'recently_viewed_state.dart';

class RecentlyViewedCubit extends HydratedCubit<RecentlyViewedState> {
  RecentlyViewedCubit(this._authenticationRepository) : super(const RecentlyViewedState(recentlyViewedProducts: []));

  final AuthenticationRepository _authenticationRepository;
  final productService = ProductService();

  // Get current authenticated user
  User getCurrentUser() {
    return _authenticationRepository.currentUser;
  }

  /// Add product ids to Recently Viewed List 
  void addToRecentlyViewed(String productId) {
    final updatedList = state.recentlyViewedProducts;
    if (updatedList.isNotEmpty) updatedList.remove(productId); // remove duplicate
    if (updatedList.length >= 8) updatedList.removeLast();
    updatedList.insert(0, productId); // add to headList
    emit(
      state.copyWith(
         recentlyViewedProducts: updatedList
      )
    );
  }

  /// Clear Recently Viewed Product List
  void clearRecentlyViewed() {
    emit(
      state.copyWith(
         recentlyViewedProducts: []
      )
    );
  }

  // bool isFavorite(String productId) {
  //   final favoriteProducts = state.favoriteProducts;
  //   if (favoriteProducts.contains(productId)) {
  //     return true;
  //   } else {
  //     return false; // add to headList
  //   }
  // }

  // void toggleFavorite(String productId) {
  //   final updatedList = state.favoriteProducts;
  //   if (updatedList.contains(productId)) {
  //     updatedList.remove(productId);
  //   } else {
  //     updatedList.add(productId); // add to headList
  //   }
  //   emit(
  //     state.copyWith(
  //        favoriteProducts: updatedList
  //     )
  //   );
  // }

  @override
  RecentlyViewedState? fromJson(Map<String, dynamic> json) {
    return RecentlyViewedState(
      recentlyViewedProducts: json['recently_viewed'] as List<String>, 
    );
  }
  
  @override
  Map<String, dynamic>? toJson(RecentlyViewedState state) {
    return{
    'recently_viewed' : state.recentlyViewedProducts, 
    };
  }                          
}