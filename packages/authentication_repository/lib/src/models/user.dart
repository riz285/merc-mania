import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart'; 

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNum,
    this.photo,
    this.followers,
    this.following
  });

  /// The current user's id.
  final String id;

  /// The current user's email address.
  final String? email;

  /// The current user's first name (display name).
  final String? firstName;

  /// The current user's last name.
  final String? lastName;


  /// The current user's phone number.
  final String? phoneNum;

  /// Url for the current user's photo.
  final String? photo;

  /// Number of user's followers & following
  final int? followers;
  final int? following;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return User(
      id: data['id'],
      email: data['email'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      phoneNum: data['phone_number'],
      photo: data['photo'],
      followers: data['followers'],  
      following: data['following']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      'email' : email,
      'first_name' : firstName,
      'last_name' : lastName,
      'phone_number': phoneNum,
      'photo' : photo,
      'followers' : followers,
      'following' : following
    };
  }

  @override
  List<Object?> get props => [id, email, firstName, lastName, phoneNum, photo, followers, following];
}