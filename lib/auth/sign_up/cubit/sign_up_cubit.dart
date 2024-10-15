import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/services/database/user_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;
  final userService = UserService();

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
          state.firstName,
          state.lastName,
          state.phoneNum
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          password,
          confirmedPassword,
          state.firstName,
          state.lastName,
          state.phoneNum
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
          state.firstName,
          state.lastName,
          state.phoneNum
        ]),
      ),
    );
  }

  // On first_name change
  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          firstName,
          state.lastName,
          state.phoneNum
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
          state.email,
          state.password,
          state.confirmedPassword,
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
          state.email,
          state.password,
          state.confirmedPassword,
          state.firstName,
          state.lastName,
          phoneNum,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      // ignore: no_leading_underscores_for_local_identifiers
      User _currentUser = _authenticationRepository.currentUser;
      User user = User(id: _currentUser.id, email: _currentUser.email, firstName: _currentUser.firstName, lastName: _currentUser.lastName, phoneNum: _currentUser.phoneNum);
      await userService.createUser(user.id, user);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}

