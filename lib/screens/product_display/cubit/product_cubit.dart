// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../../services/models/product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.product) : super(const ProductState(isFavorite: false, viewCounter: 0, userId: ''));

  final Product product;
  final favoriteProductRelationRef = FirebaseFirestore.instance.collection('user_favorite_item_relationships');
  final productService = ProductService();

  void init(String productId, String userId) {
    emit(
      state.copyWith(
        isFavorite: productService.isFavoriteByUser(productId, userId),
        userId: userId
      )) ;
  }

  void toggleFavorite(String productId, String userId) async {
    if (!state.isFavorite) {
      productService.addToFavorite(product.id, state.userId);
      emit(
        state.copyWith(
          isFavorite: true,
        ),
      );
    } else {
      productService.deleteFromFavorite(product.id,  state.userId);
      emit(
        state.copyWith(
         isFavorite: false,
        ),
      );
    }
  }
  // Cart CRUD
  // Add to cart
  void addToCart(String productId) {
    
  }
  // Delete from cart
  void deleteFromCart(String productId) {

  }

  void increaseViewCount() { 
    productService.updateProduct({'view_count': state.viewCounter});
    emit(
    state.copyWith(
          viewCounter: state.viewCounter + 1
        )
    );
  }           

  // void updateProduct() {
  //   if (!state.isFavorite) {
  //     productService.addToFavorite(product.id, state.userId);}
  //   else {
  //     productService.deleteFromFavorite(product.id,  state.userId);
  //   productService.updateProduct({'view_count': state.viewCounter});
  //   }        
  // }

  
  
}