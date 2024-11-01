import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    this.image,
    this.description,
  });

  final String id;
  final String name;
  final String? image;
  final String? description;

  static const empty = Category(id: '', name: '');

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name,
      'image' : image,
      'description': description
    };
  }

  @override
  List<Object?> get props => [id, name, image, description];
}