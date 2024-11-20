// ignore_for_file: avoid_print

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';
import 'package:merc_mania/services/database/image_storage.dart';

import '../../../services/models/product.dart';

part 'product_state.dart';

class ProductCubit extends HydratedCubit<ProductState> {
  ProductCubit(this._authenticationRepository) : super(const ProductState(recentlyViewedProducts: [], favoriteProducts: []));

  final AuthenticationRepository _authenticationRepository;
  final imageStorage = ImageStorage();
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

  /// Add Product to WishList 
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

  /// Add Product to Recently Viewed List 
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

  Future<void> productImageChanged() async {
  final pickedImage = await imageStorage.pickImage();
  if (pickedImage == null) return;
  final image = await imageStorage.uploadProductImageToStorage(pickedImage);
  emit(
    state.copyWith(
      image: image,
      isValid: (state.image!=null && state.price != 0 && state.productName != null)
    )
  );
}

  Future<void> productNameChanged(String value) async {
    final name = value;
    emit(
      state.copyWith(
        productName: name,
        isValid: (state.image!=null && state.price != 0 && state.productName != null)
      ),
    );
  }

  Future<void> brandNameChanged(String value) async {
    final brand = value;
      emit(
        state.copyWith(
          brand: brand,
          isValid: (state.image!=null && state.price != 0 && state.productName != null)
        ),
      );
  }

  Future<void> franchiseChanged(String value) async {
    final franchise = value;
      emit(
        state.copyWith(
          franchise: franchise,
          isValid: (state.image!=null && state.price != 0 && state.productName != null)
        ),
      );
  }

  Future<void> priceChanged(String value) async {
    final price = int.parse(value);
      emit(
        state.copyWith(
          price: price,
          isValid: (state.image!=null && price != 0 && state.productName != null)
        ),
      );
  }

  Future<void> quantityChanged(String value) async {
    final quantity = int.parse(value);
      emit(
        state.copyWith(
          quantity: quantity,
          isValid: (state.image!=null && state.price != 0 && state.productName != null)
        ),
      );
  }

  Future<void> descriptionChanged(String value) async {
    final description = value;
    emit(
      state.copyWith(
        description: description,
        isValid: (state.image!=null && state.price != 0 && state.productName != null)
      ),
    );
  }

  Future<void> addProductFormSubmitted() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      // Create product
      await productService.addProduct({
        'image' : state.image,
        'name' : state.productName, 
        'brand_name' : state.brand, 
        'franchise': state.franchise,
        'price' : state.price,
        'quantity' : state.quantity,
        'description' : state.description,
        'discount_percentage' : state.discount,
        'user_id' : _authenticationRepository.currentUser.id
      });
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit( 
        state.copyWith(
          // errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}

