part of 'patient_bloc.dart';
abstract class PatientState extends Equatable {
  const PatientState();
  @override
  List<Object> get props => [];

}
class PatientInitial extends PatientState {}
class PatientLoading extends PatientState {}
class PatientLoaded extends PatientState {
  
  const PatientLoaded({required this.patients});
  final List<Patient> patients;
  @override
  List<Object> get props => [patients];
}
class PatientError extends PatientState {

  const PatientError({required this.error});
    final String error;
  @override
  List<Object> get props => [error];
}
