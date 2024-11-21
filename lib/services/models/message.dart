import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.contentType,
    required this.timestamp,
  });

  final String? id;
  final String chatId;
  final String senderId;
  final String content;
  final String contentType;
  final String timestamp;

  static const empty = Message(id: '', content: '', chatId: '', senderId: '', timestamp: '', contentType: '');

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      chatId: json['chat_id'], 
      senderId: json['sender_id'],
      content: json['content'],
      contentType: json['content_type'],
      timestamp: json['timestamp']
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'chat_id' : chatId,
      'sender_id' : senderId,
      'content' : content,
      'content_type' : contentType,
      'timestamp' : timestamp
    };
  }

  @override
  List<Object?> get props => [id, content, contentType, chatId, senderId];
}