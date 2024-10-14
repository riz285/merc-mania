import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    this.title,
    this.description,
  });

  final String id;
  final String? title;
  final String? description;

  static const empty = Category(id: '');

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'title' : title,
      'description': description
    };
  }

  @override
  List<Object?> get props => [id, title, description];
}