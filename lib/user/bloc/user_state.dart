part of 'user_bloc.dart';



abstract class UserState extends Equatable{
  const UserState();
  @override
  List<Object> get props  =>[];
}
class UsersInitialState extends UserState {}

class UsersLoading extends UserState {}

class UserLoaded extends UserState {
  const UserLoaded({required this.user});
  final User user;
  @override
  List<Object> get props => [user];
}

class UsersLoadingError extends UserState {
  const UsersLoadingError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}


class PatchUserSuccess extends UserState {}

class PatchUserError extends UserState {
  const PatchUserError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

