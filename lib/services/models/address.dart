import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

class Address extends Equatable {
  const Address({
    required this.id,
    // this.country,
    // this.province,
    // this.city,
    this.ward,
    this.street,
    this.detail,
    this.name,
    this.phoneNum
  });

  final String id;
  // final Country country;
  // final Province province;
  // final City city;
  final String? ward;
  final String? street;
  final String? detail;
  final Name? name;
  final PhoneNumber? phoneNum;

  static const empty = Address(id: '');

  factory Address.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return Address(
      id: data['id'],
      // country: data['country'],
      // province: data['province'],
      // city: data['city'],
      ward: data['ward'],
      street: data['street'],
      detail: data['detail'],
      name: data['name'],
      phoneNum: data['phone_number']
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      // 'country' : country,
      // 'province' : province,
      // 'city' : city,
      'ward' : ward,
      'street' : street,
      'detail' : detail,
      'name' : name,
      'phone_number' : phoneNum
    };
  }

  @override
  List<Object?> get props => [id, ward, street, detail, name, phoneNum];
}