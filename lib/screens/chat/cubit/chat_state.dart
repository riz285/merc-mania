part of 'chat_cubit.dart';

final class ChatState extends Equatable {
  const ChatState({
    required this.chatIds,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final List<String> chatIds;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        chatIds,
        status,
        isValid,
        errorMessage,
      ];

  ChatState copyWith({
    List<String>? chatIds,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return ChatState(
      chatIds: chatIds ?? this.chatIds,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}