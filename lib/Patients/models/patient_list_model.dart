import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PatientListModel extends Equatable {
  final List<Patient> patients;

  const PatientListModel({this.patients = const []});

  factory PatientListModel.fromMap(List<dynamic> patients) {
    return PatientListModel(
        patients: List<Patient>.from(patients.map((x) => Patient.fromMap(x))));
  }
  factory PatientListModel.fromJson(String source) =>
      PatientListModel.fromMap(json.decode(source));
  @override
  String toString() => 'PatientsListModel(patients: $patients)';
  Map<String, dynamic> toMap() {
    return {
      'patients': patients.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
  PatientListModel copyWith({
    List<Patient>? patients,
  }) {
    return PatientListModel(
      patients: patients ?? this.patients,
    );
  }

  @override
  int get hashCode => patients.hashCode;
  @override
  List<Object?> get props => throw UnimplementedError();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PatientListModel && listEquals(other.patients, patients);
  }
}

class Patient {
  final int? id;
  final String first_name;
  final String last_name;
  final int age;
  final String? history;
  Patient({
    this.id,
    required this.first_name,
    required this.last_name,
    required this.age,
    this.history,
  });
  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] ?? 0,
      first_name: map['first_name'] ?? "",
      last_name: map['last_name'] ?? "",
      age: map['age'] ?? 0,
      history: map['history'] ?? "",
    );
  }
  String toJson() => json.encode(toMap());
  @override
  String toString() {
    return 'Patient(id: $id, first_name: $first_name, last_name: $last_name, age: $age, history: $history)';
  }

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));
  Patient copyWith({
    int? id,
    String? first_name,
    String? last_name,
    int? age,
    String? history,
  }) {
    return Patient(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      age: age ?? this.age,
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'age': age,
      'history': history,
    };
  }

  @override
  int get hashCode {
    return id.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        age.hashCode ^
        history.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient &&
        other.id == id &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.age == age &&
        other.history == history;
  }
}
