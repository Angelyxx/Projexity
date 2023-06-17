import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final int age;
  final String profileImageUrl;
  final List<dynamic> interests;

  static User fromSnapshot(DocumentSnapshot snap) {
    User user = User(
      id: snap['id'],
      name: snap['name'],
      age: snap['age'],
      profileImageUrl: snap['profileImageUrl'],
      interests: snap['interests'],
    );

    return user;
  }

  const User(
      {required this.id,
      required this.name,
      required this.age,
      required this.profileImageUrl,
      required this.interests});

  @override
  List<Object> get props => [id, name, age, profileImageUrl];
}
