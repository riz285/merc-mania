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
    this.description,
    this.followers,
    this.following, 
    this.preferences
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

  /// User's bio
  final String? description;

  /// Number of user's followers & following
  final int? followers;
  final int? following;

  /// User preferences
  final List<String>? preferences;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNum: json['phone_number'],
      photo: json['photo'],
      description: json['description'],
      followers: json['followers'],  
      following: json['following'],
      preferences: json['preferences']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'email' : email,
      'first_name' : firstName,
      'last_name' : lastName,
      'phone_number': phoneNum,
      'photo' : photo,
      'description' : description,
      'followers' : followers,
      'following' : following,
      'preferences' : preferences
    };
  }

  @override
  List<Object?> get props => [id, email, firstName, lastName, phoneNum, photo, description, followers, following, preferences];
}