part of 'edit_profile_bloc.dart';

@immutable
class EditProfileState {
  final String username;
  final String email;
  final bool saved;

  const EditProfileState({
    this.username = "",
    this.email = "",
    this.saved = false,
  });

  EditProfileState copyWith({
    String? username,
    String? email,
    bool? saved,
  }) {
    return EditProfileState(
      username: username ?? this.username,
      email: email ?? this.email,
      saved: saved ?? this.saved,
    );
  }
}


final class EditProfileInitial extends EditProfileState {}
