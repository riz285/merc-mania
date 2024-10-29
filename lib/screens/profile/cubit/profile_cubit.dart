import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/services/database/user_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._authenticationRepository) : super(const ProfileState());

  final AuthenticationRepository _authenticationRepository;
  final userService = UserService();

  /// Fetch current user's data
  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchUserData() async {
    try {
      return await userService.getUserInfo(_authenticationRepository.currentUser.id);
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user data: $e');
      return null;
    }
  }

  void initState() {
    emit(
      ProfileState()
    );
  }

  // On avatar change
  void avatarChanged(File image) async {
    String imgUrl = await userService.uploadImageToStorage(image);
    emit(
      state.copyWith(
        photo: imgUrl,
      )
    );
  }

  // On first_name change
  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          firstName,
          state.lastName,
          state.phoneNum,
        ]),
      ),
    );
  }

  // On last_name change
  void lastNameChanged(String value) {
    final lastName = Name.dirty(value);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([
          state.firstName,
          lastName,
          state.phoneNum,
        ]),
      ),
    );
  }

  // On phone_number change
  void phoneNumberChanged(String value) {
    final phoneNum = PhoneNumber.dirty(value);
    emit(
      state.copyWith(
        phoneNum: phoneNum,
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          phoneNum,
        ]),
      ),
    );
  }

  // User information form Save button
  Future<void> updateProfileFormSubmitted() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      User user = User(id: _authenticationRepository.currentUser.id, 
                       email: _authenticationRepository.currentUser.email, 
                       firstName: state.firstName.value, 
                       lastName: state.lastName.value, 
                       phoneNum: state.phoneNum.value, 
                       photo: state.photo);
      // Update user data
      await userService.updateUserData(user.id, user);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit( 
        state.copyWith(
          // errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}