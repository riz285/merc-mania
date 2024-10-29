part of 'product_cubit.dart';

final class ProductState extends Equatable {
  const ProductState({
    required this.isFavorite,
    required this.viewCounter,
    required this.userId
  });

  final bool isFavorite;
  final int viewCounter;
  final String userId;

  @override
  List<Object?> get props => [
        isFavorite,
        viewCounter
      ];

  ProductState copyWith({
    bool? isFavorite,
    int? viewCounter, 
    String? userId
  }) {
    return ProductState(
      isFavorite: isFavorite ?? this.isFavorite,
      viewCounter: viewCounter ?? this.viewCounter,
      userId: userId ?? this.userId
    );
  }
}