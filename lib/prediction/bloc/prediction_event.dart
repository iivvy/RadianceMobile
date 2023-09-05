part of 'prediction_bloc.dart';


abstract class PredictionEvent extends Equatable {
  const PredictionEvent();

  @override
  List<Object> get props => [];
}

class MakePredictionEvent extends PredictionEvent {
// File path or data of the image

  const MakePredictionEvent({required this.predictionData, required this.imageFile});
  final Patient predictionData; // Data to send to the API
  final XFile? imageFile; 

  @override
  List<Object> get props => [];
}
class GetActivationMapEvent extends PredictionEvent{
  const GetActivationMapEvent({required this.predictionId});

  final String predictionId;

  @override
  List<Object> get props => [];
}
