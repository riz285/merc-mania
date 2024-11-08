import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../../services/models/address.dart';

part 'address_state.dart';

class AddressCubit extends HydratedCubit<AddressState> {
  AddressCubit(this._authenticationRepository) : super(const AddressState(addresses: []));

  final AuthenticationRepository _authenticationRepository;
  final productService = ProductService();

  void initState() {
    emit(
      AddressState(addresses: state.addresses)
    );
  }

  // Get current authenticated user
  User getCurrentUser() {
    return _authenticationRepository.currentUser;
  }

  // On ward change
  void wardNameChanged(String ward) {
    emit(
      state.copyWith(
        ward: ward,
        isValid: Formz.validate([
          state.name,
          state.phoneNum,
        ]),
      ),
    );
  }

  // On street change
  void streetNameChanged(String street) {
    emit(
      state.copyWith(
        street: street,
        isValid: Formz.validate([
          state.name,
          state.phoneNum,
        ]),
      ),
    );
  }

  // On ward change
  void addressDetailChanged(String detail) {
    emit(
      state.copyWith(
        detail: detail,
        isValid: Formz.validate([
          state.name,
          state.phoneNum,
        ]),
      ),
    );
  }

  // On name change
  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([
          name,
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
          state.name,
          phoneNum,
        ]),
      ),
    );
  }

  /// Add new address
  void addToAddressList(Address address) {
    final updatedList = state.addresses.toList();
    updatedList.insert(0, address); // add to headList
    emit(
      state.copyWith(
         addresses: updatedList.toList()
      )
    );
  }

  /// Remove address
  void removeAddress(Address address) {
    final updatedList = state.addresses;
    updatedList.remove(address);
    emit(
      state.copyWith(
         addresses: updatedList
      )
    );
  }

  /// Clear all address
  // void clearAddress() {
  //   emit(
  //     state.copyWith(
  //        addresses: []
  //     )
  //   );
  // }

  Future<void> addAddressFormSubmitted() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      Address address = Address(id: id,
                                ward: state.ward,
                                street: state.street,
                                detail: state.detail,
                                name: state.name.value,
                                phoneNum: state.phoneNum.value);
      addToAddressList(address);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit( 
        state.copyWith(
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
  
  List<Address> addressesFromJson(List<dynamic> json) {
    return json.map((e) => Address.fromJson(e)).toList();
  }

  List<dynamic> addressesToJson(List<Address> addresses) {
    return addresses.map((e) => e.toFirestore()).toList();
  }

  @override
  AddressState? fromJson(Map<String, dynamic> json) {
    return AddressState(
      addresses: addressesFromJson(json['addresses'])
    );
  }
  
  @override
  Map<String, dynamic>? toJson(AddressState state) {
    return {
      'addresses' : addressesToJson(state.addresses),
    };
  }
                        
}