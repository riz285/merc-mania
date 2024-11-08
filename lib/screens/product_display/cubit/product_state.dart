part of 'product_cubit.dart';

final class ProductState extends Equatable {
  const ProductState({
    required this.recentlyViewedProducts,
    required this.favoriteProducts,
  });

  final List<String> recentlyViewedProducts;
  final List<String> favoriteProducts;

  @override
  List<Object?> get props => [
        recentlyViewedProducts,
        favoriteProducts
      ];

  ProductState copyWith({
    List<String>? recentlyViewedProducts,
    List<String>? favoriteProducts
  }) {
    return ProductState(
      recentlyViewedProducts: recentlyViewedProducts ?? this.recentlyViewedProducts,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts
    );
  }
}