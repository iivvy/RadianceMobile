import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserListModel extends Equatable {
  final List<User> users;

  const UserListModel({this.users = const []});

  factory UserListModel.fromMap(List<dynamic> users) {
    return UserListModel(
      users: List<User>.from(users.map((x) => User.fromMap(x))),
    );
  }

  factory UserListModel.fromJson(String source) =>
      UserListModel.fromMap(json.decode(source));
  @override
  String toString() => 'UserListModel(Users: $UserListModel)';
  Map<String, dynamic> toMap() {
    return {
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  UserListModel copyWith({
    List<User>? users,
  }) {
    return UserListModel(
      users: users ?? this.users,
    );
  }

  @override
  int get hashCode => users.hashCode;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserListModel && listEquals(other.users, users);
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class User {
  // final int id;
  final String first_name;
  final String last_name;
  final String email;
  final int age;
  final String speciality;
  final String hospital;
  final String profile_picture;
  final String address;

  const User({
    // required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.age,
    required this.speciality,
    required this.hospital,
    required this.profile_picture,
    required this.address,
  });
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      // id: map['id'].toInt(),
      first_name: map['first_name'] ?? "",
      last_name: map['last_name'] ?? "",
      address: map['address'] ?? "",
      email: map['email'] ?? "",
      hospital: map['hospital'] ?? "",
      speciality: map['speciality'] ?? "",
      profile_picture: map['profile_picture'] ?? "",
      age: map['age']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'address': address,
      'email': email,
      'hospital': hospital,
      'speciality': speciality,
      'profile_picture': profile_picture,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'User( first_name: $first_name, last_name: $last_name,address: $address,email : $email,hospital : $hospital,speciality : $speciality,profile_picture : $profile_picture,age:$age)';
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    // int? id,
    String? first_name,
    String? last_name,
    String? address,
    String? email,
    String? hospital,
    String? speciality,
    String? profile_picture,
    int? age,
  }) {
    return User(
      // id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      address: address ?? this.address,
      email: email ?? this.email,
      hospital: hospital ?? this.hospital,
      speciality: speciality ?? this.speciality,
      profile_picture: profile_picture ?? this.profile_picture,
      age: age ?? this.age,
    );
  }

  @override
  int get hashCode {
    return 
    // id.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        address.hashCode ^
        email.hashCode ^
        hospital.hashCode ^
        profile_picture.hashCode ^
        age.hashCode ^
        speciality.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        // other.id == id &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.email == email &&
        other.hospital == hospital &&
        other.speciality == speciality &&
        other.profile_picture == profile_picture &&
        other.age == age &&
        other.address == address;
  }
}
