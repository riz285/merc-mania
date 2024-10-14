import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    this.name,
    this.description,
    this.image,
    this.price,
  });

  final String id;
  final String? name;
  final String? description;
  final String? image;
  final double? price;

  static const empty = Product(id: '');

  @override
  List<Object?> get props => [id, name, description, image, price];
}