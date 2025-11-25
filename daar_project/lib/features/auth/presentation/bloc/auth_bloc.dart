import 'package:daar_project/core/common/app_user/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import '../../data/repositories/usecases/current_user.dart';
import '../../data/repositories/usecases/usecase.dart';
import '../../data/repositories/usecases/user_login.dart';
import '../../data/repositories/usecases/user_sign_up.dart';
import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthLogout>(_onAuthLogout);
  }

  Future<void> _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      // 1. Disconetti da Supabase
      await Supabase.instance.client.auth.signOut();

      // 2. Resetta l'AppUserCubit
      _appUserCubit.updateUser(null);

      // 3. Emetti stato di successo
      emit(AuthInitial());

      debugPrint('✅ Logout completato via AuthBloc');
    } catch (e) {
      debugPrint('❌ Errore durante il logout: $e');
      // Anche in caso di errore, resetta lo stato locale
      _appUserCubit.updateUser(null);
      emit(AuthInitial());
    }
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event,
      Emitter<AuthState> emit,
      ) async {
    final res = await _currentUser(NoParams());

    res.fold(
          (l) => emit(AuthFailure(l.message)),
          (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignUp(
      AuthSignUp event,
      Emitter<AuthState> emit,
      ) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    res.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(
      AuthLogin event,
      Emitter<AuthState> emit,
      ) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
          (l) => emit(AuthFailure(l.message)),
          (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(
      User user,
      Emitter<AuthState> emit,
      ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}