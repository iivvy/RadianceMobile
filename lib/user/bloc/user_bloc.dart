import 'package:RadianceAI/user/models/user_model.dart';
import 'package:RadianceAI/user/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  UserBloc({required this.userService}) : super(UsersInitialState()) {
    on<GetPartnersEvent>((event, emit) async {
      emit(UsersLoading());
      try {
        var response = await userService.fetchUsers();
        print(response);
        if (response is User) {
          print('reponse is $response');
          emit( UserLoaded(user: response));
        } else {
          emit(const UsersLoadingError(error: ""));
        }
      } catch (e) {
        emit(UsersLoadingError(error: e.toString()));
      }
    });

    on<PostUserAvatarEvent>((event, emit) async {
      emit(UsersLoading());
      try {
        final response =
            await userService.postUserAvatar(event.avatar, event.userId);
        if (response) {
          emit(PatchUserSuccess());
        }
      } catch (e) {
        emit(PatchUserError(error: e.toString()));
      }
    });
  }
}
