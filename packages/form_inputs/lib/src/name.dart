import 'package:formz/formz.dart';

enum NameValidationError {
  invalid
}

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');

  const Name.dirty([super.value = '']) : super.dirty();

  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
NameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? null
        : NameValidationError.invalid;
  }
}