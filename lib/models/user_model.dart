import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final int age;
  final String profileImageUrl;
  final List<dynamic> interests;
  final List<String> skills;

  static User fromSnapshot(DocumentSnapshot snap) {
    User user = User(
      id: snap['id'],
      name: snap['name'],
      age: snap['age'],
      profileImageUrl: snap['profileImageUrl'],
      interests: snap['interests'],
      skills: snap['skills'],
    );

    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'profileImageUrl': profileImageUrl,
      'interests': interests,
      'skills': skills
    };
  }

  const User(
      {required this.id,
      required this.name,
      required this.age,
      required this.profileImageUrl,
      required this.interests,
      required this.skills});

  User copyWith({
    String? id,
    String? name,
    int? age,
    String? profileImageUrl,
    List<dynamic>? interests,
    List<String>? skills,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      interests: interests ?? this.interests,
      skills: skills ?? this.skills,
    );
  }

  @override
  List<Object> get props => [id, name, age, profileImageUrl];
}
