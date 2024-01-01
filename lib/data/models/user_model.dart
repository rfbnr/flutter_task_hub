import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String role;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photo = "",
    this.role = "",
  });

  @override
  List<Object?> get props => [id, name, email, photo, role];
}
