// ignore_for_file: avoid_print

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/database/image_storage.dart';
import 'package:merc_mania/services/database/message_service.dart';

import '../../../core/configs/assets/app_format.dart';

part 'chat_state.dart';

class ChatCubit extends HydratedCubit<ChatState> {
  ChatCubit(this._authenticationRepository) : super(ChatState(chatIds: []));
  final messageService = MessageService();
  final imageStorage = ImageStorage();
  final AuthenticationRepository _authenticationRepository;

  Stream<QuerySnapshot<Map<String, dynamic>>>? fetchMessage(String id) {
    final String chatId;
    try {
      if (_authenticationRepository.currentUser.id.hashCode < id.hashCode) {
        chatId = '${_authenticationRepository.currentUser.id}_$id';
      } else { 
        chatId = '${id}_${_authenticationRepository.currentUser.id}'; 
      }
      return messageService.getMessages(chatId);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // send image
  Future<void> selectImage(String id) async {
    final pickedImage = await imageStorage.pickImage();
    if (pickedImage == null) return;
    final photo = await imageStorage.uploadImageToStorage(pickedImage);
    final String chatId;
    try {
      if (_authenticationRepository.currentUser.id.hashCode < id.hashCode) {
        chatId = '${_authenticationRepository.currentUser.id}_$id';
      } else { 
        chatId = '${id}_${_authenticationRepository.currentUser.id}'; 
      }
      messageService.addMessage({
        'sender_id' : _authenticationRepository.currentUser.id,
        'content' : photo,
        'timestamp' : AppFormat.time.format(DateTime.now()),
        'chat_id' : chatId,
        'content_type' : 'image'
      });
  } catch (e) {
    print(e);
  }
}
  // Fetch conversations user has
  

  // Send message
  void sendMessage(String id, String text) {
    final String chatId;
    try {
      if (_authenticationRepository.currentUser.id.hashCode < id.hashCode) {
        chatId = '${_authenticationRepository.currentUser.id}_$id';
      } else { 
        chatId = '${id}_${_authenticationRepository.currentUser.id}'; 
      }
      messageService.addMessage({
        'sender_id' : _authenticationRepository.currentUser.id,
        'content' : text,
        'timestamp' : AppFormat.time.format(DateTime.now()),
        'chat_id' : chatId,
        'content_type' : 'text'
      });
    } catch (e) {
      print(e);
    }
  }

  void addToChatIds(String chatId) {
    final updatedList = state.chatIds.toList();
    if (updatedList.isNotEmpty) updatedList.remove(chatId); // remove duplicate
    if (updatedList.length >= 8) updatedList.removeLast();
    updatedList.insert(0, chatId); // add to headList
    emit(
      state.copyWith(
         chatIds: updatedList.toList()
      )
    );
  }
  
  @override
  ChatState? fromJson(Map<String, dynamic> json) {
    return ChatState(
      chatIds: json['chat_ids'] as List<String>
    );
  }
  
  @override
  Map<String, dynamic>? toJson(ChatState state) {
    return {
      'chat_ids' : state.chatIds,
    };
  }

  // // clear message
  // void clearMessage() {
  //   emit(
  //     state.copyWith(
  //       chatContent: ''
  //     )
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