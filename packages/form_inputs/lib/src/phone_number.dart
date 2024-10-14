import 'package:formz/formz.dart';

/// Validation errors for the [Phone number] [FormzInput].
enum PhoneNumberValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template phone_number}
/// Form input for an phone_number input.
/// {@endtemplate}
class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  /// {@macro phone_number}
  const PhoneNumber.pure() : super.pure('');

  /// {@macro phone_number}
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  static final _phoneNumberRegExp =
      RegExp(r'^(?:\+84|0084|0)[235789][0-9]{1,2}[0-9]{7}(?:[^\d]+|$)');

  @override
  PhoneNumberValidationError? validator(String? value) {
    return _phoneNumberRegExp.hasMatch(value ?? '')
        ? null
        : PhoneNumberValidationError.invalid;
  }
}