import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<SaveProfile>(_onSaveProfile);
    on<ResetSaved>(_onResetSaved);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<EditProfileState> emit) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) return;

    final response = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    emit(state.copyWith(
      username: response['name'] ?? "",
      email: response['email'] ?? "",
    ));
  }

  Future<void> _onSaveProfile(SaveProfile event, Emitter<EditProfileState> emit) async {

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final newUsername = event.username.isEmpty ? state.username : event.username;
    final newEmail = event.email.isEmpty ? state.email : event.email;

    try {
      await Supabase.instance.client
          .from('profiles')
          .update({
        'name': newUsername,
        'email': newEmail,
      })
          .eq('id', user.id);

      emit(state.copyWith(
        username: newUsername,
        email: newEmail,
        saved: true,
      ));

    } catch (e) {
      debugPrint("Errore durante il salvataggio del profilo: $e");
    }
  }

  void _onResetSaved(ResetSaved event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(saved: false));
  }


}
