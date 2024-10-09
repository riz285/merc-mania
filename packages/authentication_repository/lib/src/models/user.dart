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
    this.name,
    this.photo,
  });

  /// The current user's id.
  final String id;

  /// The current user's email address.
  final String? email;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      photo: json['photo']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'email' : email,
      'name' : name,
      'photo' : photo,
    };
  }

  @override
  List<Object?> get props => [id, email, name, photo];
}