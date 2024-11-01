import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  const Review({
    required this.id,
    this.rating,
    this.comment,
    this.createdAt,
    this.productId,
    this.userId,
  });

  final String id;
  final bool? rating;
  final String? comment;
  final String? createdAt;
  final String? productId;
  final String? userId;

  static const empty = Review(id: '');

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['createdAt'],
      productId: json['productId'],
      userId: json['userId']
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'rating' : rating,
      'comment' : comment,
      'createdAt' : createdAt,
      'productId' : productId,
      'userId' : userId
    };
  }

  @override
  List<Object?> get props => [id, rating, comment, createdAt, productId, userId];
}