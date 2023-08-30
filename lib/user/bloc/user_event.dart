part of 'user_bloc.dart';
abstract class UserEvent extends Equatable {
  const UserEvent();

  List<Object> get props => [];
}

class GetPartnersEvent extends UserEvent {}

class PatchUser extends UserEvent {
  const PatchUser(
      {required this.userId, required this.updatedUserData});
  final int userId;
  final Map updatedUserData;
  @override
  List<Object> get props => [];
}


class PostUserAvatarEvent extends UserEvent {
  const PostUserAvatarEvent({required this.avatar, required this.userId});
  final XFile? avatar;
  final int userId;
}