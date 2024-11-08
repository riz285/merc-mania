import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/services/database/image_storage.dart';
import 'package:merc_mania/services/database/user_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._authenticationRepository) : super(const ProfileState());

  final AuthenticationRepository _authenticationRepository;
  final userService = UserService();
  final imageStorage = ImageStorage();

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

  Future<void> avatarChanged() async {
    final pickedImage = await imageStorage.pickImage();
    if (pickedImage != null) {
      final photo = await imageStorage.uploadImageToStorage(pickedImage);
      emit(
        state.copyWith(
          photo: photo
        )
      );
    }
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
      // Update user data
      await userService.updateUserData(_authenticationRepository.currentUser.id, {
        'first_name' : state.firstName.value, 
        'last_name' : state.lastName.value, 
        'phone_number': state.phoneNum.value
      });
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
