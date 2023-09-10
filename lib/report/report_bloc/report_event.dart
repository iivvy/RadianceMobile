part of 'report_bloc.dart';
abstract class ReportEvent extends Equatable {
  const ReportEvent();
  @override
  List<Object> get props => [];
}

class GetReportsEvent extends ReportEvent {
  const GetReportsEvent({required this.predId});
  final String predId;
  @override
  List<Object> get props => [];
}