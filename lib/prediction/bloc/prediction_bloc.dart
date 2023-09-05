import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:RadianceAI/prediction/models/predict_list_model.dart';
import 'package:RadianceAI/prediction/predict_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'prediction_event.dart';
part 'prediction_state.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  final PredictService predictService;
  PredictionBloc({required this.predictService}) : super(PredictionInitial()) {
    on<MakePredictionEvent>((event, emit) async {
      emit(PredictionLoading());
      try {
        var response = await predictService.predictImage(
            event.predictionData, event.imageFile!);
        if (response is String) {
          emit(PredictionCreated());
        } else {
          emit(PredictionCreatedFailed(error: 'error'));
        }
      } catch (e) {
        emit(PredictionCreatedFailed(error: e.toString()));
      }
    });
    on<GetActivationMapEvent>((event, emit) async {
      emit(PredictionLoading());
      try {
        var response =
            await predictService.fetchActivationMap(event.predictionId);
        if (response is String) {
          emit(PredictionCreated());
        } else {
          emit(PredictionCreatedFailed(error: response!.toString()));
        }
      } catch (e) {
        emit(PredictionCreatedFailed(error: e.toString()));
      }
    });
  }
}
