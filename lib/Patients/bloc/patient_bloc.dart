import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:RadianceAI/Patients/patients_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_state.dart';
part 'patient_event.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final PatientService patientService;
  PatientBloc({required this.patientService}) : super(PatientInitial()){
    on<GetPatientsEvent> ((event, emit) async {
        emit(PatientLoading());
        try {
          var response = await patientService.fetchPatients();
          if (response is PatientListModel) {
            emit(PatientLoaded(patients: response.patients));
          } else {
            emit(const PatientError(error: ""));
          }
        } catch (e) {
          // print(e);
          emit(PatientError(error: e.toString()));
        }
      });
      }
  
}
