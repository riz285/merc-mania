part of 'address_cubit.dart';

final class AddressState extends Equatable {
  const AddressState({
    required this.addresses,
    this.ward,
    this.street,
    this.detail,
    this.name = const Name.pure(),
    this.phoneNum = const PhoneNumber.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final List<Address> addresses;
  final String? ward;
  final String? street;
  final String? detail;
  final Name name;
  final PhoneNumber phoneNum;  
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        addresses,
        ward,
        street,
        detail,
        name,
        phoneNum,
        status,
        isValid,
        errorMessage,
      ];

  AddressState copyWith({
    List<Address>? addresses,
    String? ward,
    String? street,
    String? detail,
    Name? name,
    PhoneNumber? phoneNum,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return AddressState(
      addresses: addresses ?? this.addresses,
      ward: ward ?? this.ward,
      street: street ?? this.street,
      detail: detail ?? this.detail,
      name: name ?? this.name,
      phoneNum: phoneNum ?? this.phoneNum,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}