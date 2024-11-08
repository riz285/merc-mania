part of 'chat_cubit.dart';

final class ChatState extends Equatable {
  const ChatState({
    required this.messages,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final List<Message> messages;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        messages,
        status,
        isValid,
        errorMessage,
      ];

  ChatState copyWith({
    required List<Message> messages,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}