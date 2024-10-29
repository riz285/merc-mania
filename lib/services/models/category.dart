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

  factory Category.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return Category(
      id: data['id'],
      name: data['name'],
      image: data['image'],
      description: data['description']);
  }

  Map<String, dynamic> toFirestore() {
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