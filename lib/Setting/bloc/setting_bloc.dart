import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:RadianceAI/Setting/models/saved_app_Settings.dart';
import 'package:RadianceAI/Setting/setting_repo.dart';

import '../models/saved_app_Settings.dart';
import '../setting_repo.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent,SettingState>{
  final SettingService settingService;
  String theme = 'light';
  SettingBloc({required this.settingService}) : super(SettingInitial()){
    on<GetSavedSettings>((event,emit) async{
      emit(SettingLoadingState());
      try{
        final SavedAppSettings response = await settingService.getSettings;
        theme = response.theme;
        emit(SettingsLoaded(settings: response));

      } catch(e){
        emit(SettingLoadedError(error: e.toString()));
      }
    });
    on<UpdateSettingStringValue>((event,emit) async{
      emit(SettingLoadingState());
      try{
        final SavedAppSettings response = await settingService.setStringValue(event.key,event.value);
        theme = response.theme;
        emit(SettingsLoaded(settings: response));


      } catch(e){
        emit(SettingLoadedError(error: e.toString()));
      }
    });
    on<UpdateSettingIntegerValue>((event, emit) async {
      emit(SettingLoadingState());
      try {
        final SavedAppSettings response =
        await settingService.setIntegerValue(event.key, event.value);
        theme = response.theme;
        emit(SettingsLoaded(settings: response));
      } catch (e) {
        emit(SettingLoadedError(error: e.toString()));
      }
    });
  }
}