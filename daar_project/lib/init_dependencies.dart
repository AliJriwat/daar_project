import 'package:daar_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:daar_project/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:daar_project/features/auth/data/repositories/usecases/user_login.dart';
import 'package:daar_project/features/auth/data/repositories/usecases/user_sign_up.dart';
import 'package:daar_project/features/auth/domain/repository/auth_repository.dart';
import 'package:daar_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/app_user/app_user_cubit.dart';
import 'core/secrets/app_secrets.dart';
import 'features/auth/data/repositories/usecases/current_user.dart';
import 'features/profile/data/repositories/settings_repository_impl.dart';
import 'features/profile/domain/repositories/settings_repository.dart';
import 'features/profile/presentation/cubit/settings_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // 1️⃣ Inizializza Supabase e registra il client
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // 2️⃣ Inizializza Auth (RemoteDataSource, Repository, UseCases, Bloc)
  _initAuth();
}

void _initAuth() {
  // Remote Data Source
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => UserSignUp(serviceLocator()));
  serviceLocator.registerLazySingleton(() => UserLogin(serviceLocator()));
  serviceLocator.registerLazySingleton(() => CurrentUser(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  // Bloc
  serviceLocator.registerLazySingleton(() => AuthBloc(
    userSignUp: serviceLocator(),
    userLogin: serviceLocator(),
    currentUser: serviceLocator<CurrentUser>(),
    appUserCubit: serviceLocator(),
  ));
}

void _initSettings() {
  // Remote Data Source
  serviceLocator.registerLazySingleton<SettingsRemoteDatasource>(
        () => SettingsRemoteDatasource(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(serviceLocator()),
  );

  // Cubit - Factory per creare nuovo instance ogni volta
  serviceLocator.registerFactory<SettingsCubit>(
        () => SettingsCubit(
      settingsRepository: serviceLocator(),
      userId: serviceLocator<SupabaseClient>().auth.currentUser?.id ?? '',
    ),
  );
}