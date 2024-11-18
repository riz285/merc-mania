import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    required this.id,
    this.country,
    this.province,
    this.city,
    this.ward,
    this.street,
    this.detail,
    this.name,
    this.phoneNum
  });

  final String id;
  final String? country;
  final String? province;
  final String? city;
  final String? ward;
  final String? street;
  final String? detail;
  final String? name;
  final String? phoneNum;

  static const empty = Address(id: '');

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      country: json['country'],
      province: json['province'],
      city: json['city'],
      ward: json['ward'],
      street: json['street'],
      detail: json['detail'],
      name: json['name'],
      phoneNum: json['phone_number']
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      'country' : country,
      'province' : province,
      'city' : city,
      'ward' : ward,
      'street' : street,
      'detail' : detail,
      'name' : name,
      'phone_number' : phoneNum
    };
  }

  @override
  List<Object?> get props => [id, country, province, city, ward, street, detail, name, phoneNum];
}