import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    this.brandName,
    required this.price,
    this.quantity,
    this.isInStock,
    this.discountPercentage,
    this.viewCount,
    this.franchise,
    this.userId
  });

  final String id;
  final String name;
  final String image;
  final String? description;
  final String? brandName;
  final int price;
  final int? quantity;
  final bool? isInStock;
  final int? discountPercentage;
  final int? viewCount;
  final String? franchise;
  final String? userId;

  static const empty = Product(id: '', name: '', image: '', price: 0);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      brandName: json['brand_name'],
      price: json['price'],
      quantity: json['quantity'],
      isInStock: json['is_in_stock'],
      discountPercentage: json['discount_percentage'],
      viewCount: json['view_count'],
      franchise: json['franchise'],
      userId: json['user_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name,
      'image' : image,
      'description': description,
      'brand_name' : brandName,
      'price' : price,
      'quantity' : quantity,
      'isInStock' : isInStock,
      'discount_percentage' : discountPercentage,
      'view_count' : viewCount,
      'franchise' : franchise,
      'user_id' : userId
    };
  }

  @override
  List<Object?> get props => [id, name, image, description, brandName, price, quantity, isInStock, discountPercentage, viewCount, franchise, userId];

}