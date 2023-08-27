part of 'profile_bloc.dart';


abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class PatchProfileEvent extends ProfileEvent {
  const PatchProfileEvent({required this.value});
  final Map value;
}

class PostUserAvatarEvent extends ProfileEvent {
  const PostUserAvatarEvent({required this.avatar});
  final XFile? avatar;
}