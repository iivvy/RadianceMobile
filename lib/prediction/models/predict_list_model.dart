import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PredictionListModel extends Equatable {
  final List<Prediction> predictions;

  const PredictionListModel({this.predictions = const []});

  factory PredictionListModel.fromMap(List<dynamic> predictions) {
    return PredictionListModel(
        predictions: List<Prediction>.from(
            predictions.map((x) => Prediction.fromMap(x))));
  }
  factory PredictionListModel.fromJson(String source) =>
      PredictionListModel.fromMap(json.decode(source));
  @override
  String toString() => 'PredictionsListModel(predictions: $predictions)';

  Map<String, dynamic> toMap() {
    return {
      'predictions': predictions.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
  PredictionListModel copyWith({
    List<Prediction>? predictions,
  }) {
    return PredictionListModel(
      predictions: predictions ?? this.predictions,
    );
  }

  @override
  int get hashCode => predictions.hashCode;
  @override
  List<Object?> get props => throw UnimplementedError();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PredictionListModel &&
        listEquals(other.predictions, predictions);
  }
}

class Prediction {
  final String? id;
  final String? pateintId;
  final String? image;
  final Map<String, dynamic>? results;
  Prediction({
    this.id,
    this.pateintId,
    this.image,
    this.results,
  });
  factory Prediction.fromMap(Map<String, dynamic> map) {
    return Prediction(
      id: map['id'] ?? "",
      pateintId: map['pateintId'] ?? "",
      image: map['image'] ?? "",
      results: Map<String, dynamic>.from(map['results']),
    );
  }
  factory Prediction.fromJson(String source) =>
      Prediction.fromMap(json.decode(source));
  Prediction copyWith({
    String? id,
    String? pateintId,
    String? image,
    Map<String, dynamic>? results,
  }) {
    return Prediction(
      id: id ?? this.id,
      pateintId: pateintId ?? this.pateintId,
      image: image ?? this.image,
      results: results ?? this.results,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pateintId': pateintId,
      'image': image,
      'results': results,
    };
  }
  @override
  int get hashCode {
    return id.hashCode ^
        pateintId.hashCode ^
        image.hashCode ^
        results.hashCode;
  }
  @override 
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Prediction &&
      other.id == id &&
      other.pateintId == pateintId &&
      other.image == image &&
      mapEquals(other.results, results);
  }
}
