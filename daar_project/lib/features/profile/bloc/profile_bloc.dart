// profile_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ThemeLight()) {
    on<ToggleTheme>((event, emit) {
      if (state is ThemeLight) {
        emit(ThemeDark(locale: state.locale));
      } else {
        emit(ThemeLight(locale: state.locale));
      }
    });

    on<ChangeLanguage>((event, emit) {
      if (state is ThemeLight) {
        emit(ThemeLight(locale: event.locale));
      } else {
        emit(ThemeDark(locale: event.locale));
      }
    });
  }
}

