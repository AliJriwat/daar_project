part of 'edit_profile_bloc.dart';


@immutable
sealed class EditProfileEvent {}

class LoadProfile extends EditProfileEvent {}

class SaveProfile extends EditProfileEvent {
  final String username;
  final String email;

  SaveProfile({required this.username, required this.email});
}

class ResetSaved extends EditProfileEvent {}

