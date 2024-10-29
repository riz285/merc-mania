import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Franchise extends Equatable {
  const Franchise({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    this.favoriteCount
  });

  final String id;
  final String name;
  final String image;
  final String? description;
  final int? favoriteCount;

  static const empty = Franchise(id: '', name: '', image: '');

  factory Franchise.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return Franchise(
      id: data['id'],
      name: data['name'],
      image: data['image'],
      description: data['description'] ?? '',
      favoriteCount: data['favorite_count'] ?? 0
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      'name' : name,
      'image' : image,
      'description' : description,
      'favorite_count' : favoriteCount
    };
  }

  @override
  List<Object?> get props => [id, name, image, description, favoriteCount];
}