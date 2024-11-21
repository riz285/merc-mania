part of 'product_cubit.dart';

final class ProductState extends Equatable {
  const ProductState({
    required this.recentlyViewedProducts,
    required this.favoriteProducts,
    //
    this.image,
    this.productName,
    this.brand,
    this.franchise,
    this.price,
    this.quantity,
    this.description,
    //
    this.discount,
    //
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final List<String> recentlyViewedProducts;
  final List<String> favoriteProducts;
  //
  final String? image;
  final String? productName;
  final String? brand;
  final String? franchise;
  final int? price;
  final int? quantity;
  final String? description;
  //
  final int? discount;
  //
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props => [
        recentlyViewedProducts,
        favoriteProducts,
        //
        image,
        productName,
        brand,
        franchise,
        price,
        quantity,
        description,
        //
        discount,
        //
        isValid,
        status
      ];

  ProductState copyWith({
    List<String>? recentlyViewedProducts,
    List<String>? favoriteProducts,
    //
    String? image,
    String? productName,
    String? brand,
    String? franchise,
    int? price,
    int? quantity,
    String? description,
    //
    int? discount,
    //
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ProductState(
      recentlyViewedProducts: recentlyViewedProducts ?? this.recentlyViewedProducts,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      image: image ?? this.image,
      productName: productName ?? this.productName,
      brand: brand ?? this.brand,
      franchise: franchise ?? this.franchise,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status
    );
  }
}