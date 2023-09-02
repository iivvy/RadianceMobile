part of 'prediction_bloc.dart';
abstract class PredictionState extends Equatable {
  const PredictionState();
  @override
  List<Object> get props => [];
  get predictions => null;
}
class PredictionInitial extends PredictionState {}
class PredictionLoading extends PredictionState {}
class PredictionLoaded extends PredictionState {
  
  const PredictionLoaded({required this.predictions});
  final List<Prediction> predictions;
  @override
  List<Object> get props => [predictions];
}
class PredictionError extends PredictionState {

  const PredictionError({required this.error});
    final String error;
  @override
  List<Object> get props => [error];
}

class PredictionCreated extends PredictionState {}

class PredictionCreatedFailed extends PredictionState {
  const PredictionCreatedFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
