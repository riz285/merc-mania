import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../../services/models/product.dart';

part 'product_item_state.dart';

class ProductItemCubit extends HydratedCubit<ProductItemState> {
  final Product product;
  ProductItemCubit(this.product) : super(const ProductItemState(isFavorite: false));

  final productService = ProductService();

  void increaseView() {
    final count = product.viewCount ?? 0;
    productService.updateProduct(id, {'view': count});
  }

  void toggleFavorite() {
    emit(
      state.copyWith(
        isFavorite: !state.isFavorite
      )
    );
  }
  
  @override
  ProductItemState? fromJson(Map<String, dynamic> json) {
    return ProductItemState(
      isFavorite: json['is_favorite'] as bool
      );
  }
  
  @override
  Map<String, dynamic>? toJson(ProductItemState state) {
    return{
    'is_favorite' : state.isFavorite, 
    };
  }                     
}