import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    this.brandName,
    required this.price,
    required this.quantity,
    required this.isSold,
    this.discountPercentage,
    required this.viewCount,
    this.franchise,
    required this.userId,
    required this.timestamp
  });

  final String id;
  final String name;
  final String image;
  final String? description;
  final String? brandName;
  final int price;
  final int quantity;
  final bool isSold;
  final int? discountPercentage;
  final int viewCount;
  final String? franchise;
  final String userId;
  final String timestamp;

  static const empty = Product(id: '', name: '', image: '', price: 0, timestamp: '', userId: '', quantity: 0, isSold: false, viewCount: 0);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']??'',
      name: json['name'],
      image: json['image'],
      description: json['description'],
      brandName: json['brand_name'],
      price: json['price'],
      quantity: json['quantity'],
      isSold: json['is_sold'],
      discountPercentage: json['discount_percentage'],
      viewCount: json['view_count'],
      franchise: json['franchise'],
      userId: json['user_id'],
      timestamp: json['timestamp']
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
      'is_sold' : isSold,
      'discount_percentage' : discountPercentage,
      'view_count' : viewCount,
      'franchise' : franchise,
      'user_id' : userId,
      'timestamp' : timestamp
    };
  }

  @override
  List<Object?> get props => [id, name, image, description, brandName, price, quantity, isSold, discountPercentage, viewCount, franchise, userId, timestamp];

}