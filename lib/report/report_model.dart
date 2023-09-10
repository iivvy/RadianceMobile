import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ReportListModel extends Equatable {
  final List<Report> reports;
  const ReportListModel({this.reports = const []});
  factory ReportListModel.fromMap(List<dynamic> reports) {
    return ReportListModel(
        reports: List<Report>.from(
          reports.map((x) => Report.fromMap(x))));
  }
  factory ReportListModel.fromJson(String source) =>
      ReportListModel.fromMap(json.decode(source));
  @override
  String toString() => 'ReportsListModel(reports: $reports)';
  Map<String, dynamic> toMap() {
    return {
      'reports': reports.map((x) => x.toMap()).toList(),
    };
  }
  String toJson() => json.encode(toMap());
  ReportListModel copyWith({
    List<Report>? reports,
  }) {
    return ReportListModel(
      reports: reports ?? this.reports,
    );
  }

  @override
  int get hashCode => reports.hashCode;
  @override
  List<Object?> get props => throw UnimplementedError();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReportListModel &&
        listEquals(other.reports, reports);
  }
      
}
class Report{
  final String? id;
  final String? patientId;
  final String? predictionId;
  final String? doctorId;
  final int exam_number;
  final String status;
  final String findings;
  final Map<String, dynamic>? observations;
  final String recommendations;
  Report({
    this.id,
    this.patientId,
    this.predictionId,
    this.doctorId,
    required this.exam_number,
    required this.status,
    required this.findings,
    this.observations,
    required this.recommendations,
  
  });
  factory Report.fromMap(Map<String,dynamic>map){
    return Report(
      id: map['id'] ?? "",
      patientId: map['patientId'] ?? "",
      predictionId: map['predictionId'] ?? "",
      doctorId: map['doctorId'] ?? "",
      exam_number: map['exam_number'] ?? 0,
      status: map['status'] ?? "",
      findings: map['findings'] ?? "",
      observations: Map<String, dynamic>.from(map['observations']),
      recommendations: map['recommendations'] ?? "",
    );
  }
  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source));
  Report copyWith({
    String? id,
    String? patientId,
    String? predictionId,
    String? doctorId,
    int? exam_number,
    String? status,
    String? findings,
    Map<String, dynamic>? observations,
    String? recommendations,
  }) {
    return Report(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      predictionId: predictionId ?? this.predictionId,
      doctorId: doctorId ?? this.doctorId,
      exam_number: exam_number ?? this.exam_number,
      status: status ?? this.status,
      findings: findings ?? this.findings,
      observations: observations ?? this.observations,
      recommendations: recommendations ?? this.recommendations,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'predictionId': predictionId,
      'doctorId': doctorId,
      'exam_number': exam_number,
      'status': status,
      'findings': findings,
      'observations': observations,
      'recommendations': recommendations,
    };
  }
  @override
  int get hashCode {
    return id.hashCode ^
        patientId.hashCode ^
        predictionId.hashCode ^
        doctorId.hashCode ^
        exam_number.hashCode ^
        status.hashCode ^
        findings.hashCode ^
        observations.hashCode ^
        recommendations.hashCode;
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Report &&
      other.id == id &&
      other.patientId == patientId &&
      other.predictionId == predictionId &&
      other.doctorId == doctorId &&
      other.exam_number == exam_number &&
      other.status == status &&
      other.findings == findings &&
      other.observations == observations &&
      other.recommendations == recommendations;
  }
}
