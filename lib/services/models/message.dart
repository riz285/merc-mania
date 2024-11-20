import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    required this.chatId,
    required this.senderId,
    this.id,
    required this.content,
    this.image,
    required this.timestamp,
  });

  final String chatId;
  final String senderId;
  final String? id;
  final String content;
  final String? image;
  final String timestamp;

  static const empty = Message(id: '', content: '', chatId: '', senderId: '', timestamp: '');

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      image: json['image'], 
      chatId: json['chat_id'], 
      senderId: json['sender_id'],
      timestamp: json['timestamp']
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'content' : content,
      'image' : image,
      'chat_id' : chatId,
      'sender_id' : senderId,
      'timestamp' : timestamp
    };
  }

  @override
  List<Object?> get props => [id, content, image, chatId, senderId];
}