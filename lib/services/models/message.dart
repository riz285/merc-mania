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

  factory Message.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return Message(
      id: data['id'],
      content: data['content'],
      image: data['image'],
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      'content' : content,
      'image' : image,
    };
  }

  @override
  List<Object?> get props => [id, content, image];
}