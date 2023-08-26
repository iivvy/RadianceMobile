import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


class UserListModel extends Equatable {
  final List<User> users;

  const UserListModel({this.users = const []});

  factory UserListModel.fromMap(List<dynamic> partners) {
    return UserListModel(
      users: List<User>.from(partners.map((x) => User.fromMap(x))),
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
  final int id;
  final String name;
  final String phone;
  final String address;
  final String email;
  final String website;
  final String status;
  final String photo;
  final String stripeId;


  const User(
      {required this.id,
        required this.name,
        required this.phone,
        required this.address,
        required this.email,
        required this.website,
        required this.status,
        required this.photo,

        required this.stripeId});
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toInt(),
      name: map['name'] ?? "",
      phone: map['phone'] ?? "",
      address: map['address'] ?? "",
      email: map['email'] ?? "",
      website: map['website'] ?? "",
      status: map['status'] ?? "",
      photo: map['photo'] ?? "",
      stripeId: map['stripeId'] ?? "",

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'website': website,
      'status': status,
      'photo': photo,
      'stripeId': stripeId,

    };
  }

  @override
  String toString() {
    return 'Partner(id: $id, name: $name, phone: $phone,address: $address,email : $email,website : $website,status : $status,photo : $photo,stripeId:$stripeId)';
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source));

  User copyWith({
    int? id,
    String? name,
    String? phone,
    String? address,
    String? email,
    String? website,
    String? status,
    String? photo,
    String? stripeId,

  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
      website: website ?? this.website,
      status: status ?? this.status,
      photo: photo ?? this.photo,
      stripeId: stripeId ?? this.stripeId,

    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    phone.hashCode ^
    address.hashCode ^
    email.hashCode ^
    status.hashCode ^
    photo.hashCode ^

    stripeId.hashCode ^
    website.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.website == website &&
        other.status == status &&
        other.photo == photo &&

        other.stripeId == stripeId &&
        other.address == address;
  }
}