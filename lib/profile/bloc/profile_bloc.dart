import 'package:RadianceAI/profile/profile_repo.dart';
import 'package:RadianceAI/user/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileService profileService;
  ProfileBloc({required this.profileService}) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        var response = await profileService.getUserProfile();
        if (response is User) {
          emit(ProfileLoaded(user: response));
        } else {
          emit(const ProfileLoadError(error: " "));
        }
      } catch (e) {
        emit(ProfileLoadError(error: e.toString()));
      }
    });

    on<PatchProfileEvent>((event, emit) async {
      try {
        var response = await profileService.patchUserProdile(event.value);
        if (response) {
          emit(ProfileUpdated());
        } else {
          emit(const ProfileUpdateFailed(error: ""));
        }
      } catch (e) {
        emit(const ProfileUpdateFailed(error: ""));
      }
    });
    on<PostUserAvatarEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final response = await profileService.postProfilePhoto(event.avatar);
        if (response) {
          emit(ProfileUpdated());
        }
      } catch (e) {
        emit(ProfileUpdateFailed(error: e.toString()));
      }
    });
  }
}