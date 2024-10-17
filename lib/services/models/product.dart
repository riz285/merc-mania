import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    this.brandName,
    this.price,
    this.quantity,
    this.isInStock,
    this.discountPercentage
  });

  final String id;
  final String name;
  final String image;
  final String? description;
  final String? brandName;
  final int? price;
  final int? quantity;
  final bool? isInStock;
  final int? discountPercentage;

  static const empty = Product(id: '', name: '', image: '', description: '', brandName: '', price: 0, quantity: 0, isInStock: false, discountPercentage: 0);

  factory Product.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return Product(
      id: data['id'],
      name: data['name'],
      image: data['image'],
      description: data['description'] ?? '',
      brandName: data['brand_name'] ?? '',
      price: data['price'] ?? 0,
      quantity: data['quantity'] ?? 0,
      isInStock: data['is_in_stock'] ?? false,
      discountPercentage: data['discount_percentage'] ?? 0
    );
  }

  Map<String, dynamic> toFirestore() {
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
    };
  }

  @override
  List<Object?> get props => [id, name, image, description, brandName, price, quantity, isInStock, discountPercentage];

}