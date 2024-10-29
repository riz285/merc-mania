part of 'profile_cubit.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.photo,
    this.email = const Email.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.phoneNum = const PhoneNumber.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final String? photo;
  final Email email;
  final Name firstName;
  final Name lastName;
  final PhoneNumber phoneNum;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        photo,
        email,
        firstName,
        lastName,
        phoneNum,
        status,
        isValid,
        errorMessage,
      ];

  ProfileState copyWith({
    String? photo,
    Email? email,
    Name? firstName,
    Name? lastName,
    PhoneNumber? phoneNum,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return ProfileState(
      photo: photo ?? this.photo,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNum: phoneNum ?? this.phoneNum,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}