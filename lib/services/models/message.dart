import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.content,
    this.image,
  });

  final String id;
  final String content;
  final String? image;

  static const empty = Message(id: '', content: '');

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'content' : content,
      'image' : image,
    };
  }

  @override
  List<Object?> get props => [id, content, image];
}