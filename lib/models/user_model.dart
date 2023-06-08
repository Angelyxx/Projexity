import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final String profileImageUrl;

  const User(
      {required this.id,
      required this.name,
      required this.age,
      required this.profileImageUrl});

  @override
  List<Object> get props => [id, name, age, profileImageUrl];
}
