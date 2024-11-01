part of 'product_cubit.dart';

final class ProductState extends Equatable {
  const ProductState({
    required this.recentlyViewedProducts,
  });

  final List<String> recentlyViewedProducts;

  @override
  List<Object?> get props => [
        recentlyViewedProducts,
      ];

  ProductState copyWith({
    List<String>? recentlyViewedProducts,
  }) {
    return ProductState(
      recentlyViewedProducts: recentlyViewedProducts ?? this.recentlyViewedProducts,
    );
  }
}