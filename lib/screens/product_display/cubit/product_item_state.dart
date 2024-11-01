part of 'product_item_cubit.dart';

final class ProductItemState extends Equatable {
  const ProductItemState({
    required this.isFavorite
  });

  final bool isFavorite;

  @override
  List<Object?> get props => [
        isFavorite
      ];

  ProductItemState copyWith({
    int? view,
    bool? isFavorite
  }) {
    return ProductItemState(
      isFavorite: isFavorite ?? this.isFavorite
    );
  }
}