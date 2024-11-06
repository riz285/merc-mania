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

  factory Franchise.fromJson(Map<String, dynamic> json) {
    return Franchise(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'] ?? '',
      favoriteCount: json['favorite_count'] ?? 0
      );
  }

  Map<String, dynamic> toJson() {
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