import 'package:RadianceAI/report/report_model.dart';
import 'package:RadianceAI/report/report_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'report_state.dart';
part 'report_event.dart';



class ReportBloc extends Bloc<ReportEvent,ReportState>{
  final ReportService reportService;
  ReportBloc({required this.reportService}) : super(ReportInitial()){
    on<GetReportsEvent>((event,emit) async {
      emit(ReportLoading());
      try{
        var response = await reportService.getReport(event.predId);
        if(response is Map<String, dynamic>){
            print('report bloc: report response received');
          print(response);
          emit(ReportCreated(reports: response));
           print('report bloc: report state emitted');
        }else{
          emit(ReportError(error: response.toString()));
        }
      }catch(e){
        emit(ReportError(error: e.toString()));
      }
    });
  }

}