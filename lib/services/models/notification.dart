import 'package:equatable/equatable.dart';

class AppNotification extends Equatable {
  const AppNotification({
    required this.id,
    this.category,
    this.name,
    this.description,
    this.timestamp
  });

  final String id;
  final String? category;
  final String? name;
  final String? description;
  final String? timestamp;

  static const empty = AppNotification(id: '');

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      category: json['category'],
      name: json['name'],
      description: json['description'] ?? '',
      timestamp: json['timestamp']
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'category' : category,
      'name' : name,
      'description' : description,
      'timestamp' : timestamp
    };
  }

  @override
  List<Object?> get props => [id, category, name, description, timestamp];
}