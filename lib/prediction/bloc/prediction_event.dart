part of 'prediction_bloc.dart';


abstract class PredictionEvent extends Equatable {
  const PredictionEvent();

  @override
  List<Object> get props => [];
}

class MakePredictionEvent extends PredictionEvent{
  const MakePredictionEvent({required this.predictionData});

  final Prediction predictionData;

  @override
  List<Object> get props => [];
}
class GetActivationMapEvent extends PredictionEvent{
  const GetActivationMapEvent({required this.predictionId});

  final String predictionId;

  @override
  List<Object> get props => [];
}
