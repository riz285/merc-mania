import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/services/database/message_service.dart';

import '../../../services/models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._authenticationRepository) : super(ChatState(messages: []));
  final messageService = MessageService();
  final AuthenticationRepository _authenticationRepository;

  // Get current authenticated user
  User getCurrentUser() {
    return _authenticationRepository.currentUser;
  }

  // On first_name change
  // void chatContentChanged(String value) {
  //   final chatContent;
  //   emit(
  //     state.copyWith(
  //       chatContent: chatContent,
  //       isValid: Formz.validate([
  //         chatContent,
  //       ]),
  //     ),
  //   );
  // }

  // User information form Save button
  // Future<void> updateChatFormSubmitted() async {
  //   if (!state.isValid) return;
  //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
  //   try {
      
  //     emit(state.copyWith(status: FormzSubmissionStatus.success));
  //   // } on SignUpWithEmailAndPasswordFailure catch (e) {
  //   } catch (e) {
  //     emit( 
  //       state.copyWith(
  //         // errorMessage: e.message,
  //         status: FormzSubmissionStatus.failure,
  //       ),
  //     );
  //   // } catch (_) {
  //   //   emit(state.copyWith(status: FormzSubmissionStatus.failure));
  //   }
  // }
}