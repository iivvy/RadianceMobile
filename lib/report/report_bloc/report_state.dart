part of 'report_bloc.dart';
abstract class ReportState extends Equatable {
  const ReportState();
  @override
  List<Object> get props => [];
}
class ReportInitial extends ReportState {}
class ReportLoading extends ReportState {}
class ReportLoaded extends ReportState {
  
  const ReportLoaded({required this.reports});
  final List<Report> reports;
  @override
  List<Object> get props => [reports];
}
class ReportError extends ReportState {

  const ReportError({required this.error});
    final String error;
  @override
  List<Object> get props => [error];
}
class ReportCreated extends ReportState {
  final Map<String, dynamic> reports; // Updated to Map<String, dynamic>

  const ReportCreated({required this.reports});

  @override
  List<Object> get props => [reports];
}
class ReportCreatedFailed extends ReportState {
  const ReportCreatedFailed({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}