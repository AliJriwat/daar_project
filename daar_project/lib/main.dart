import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:daar_project/app/theme/theme.dart';
import 'package:daar_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:daar_project/features/auth/presentation/pages/login_page.dart';
import 'package:daar_project/features/home/presentation/pages/main_page.dart';
import 'package:daar_project/core/common/app_user/app_user_cubit.dart';
import 'package:daar_project/init_dependencies.dart';
import 'app/routes/app_router.dart';
import 'features/profile/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'features/profile/bloc/profile_bloc.dart';
import 'features/profile/bloc/profile_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
          BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
          BlocProvider(create: (_) => ProfileBloc()),
          BlocProvider(create: (_) => EditProfileBloc()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightThemeMode,
          darkTheme: AppTheme.darkThemeMode,
          themeMode: profileState.themeMode,
          locale: profileState.locale ?? context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          onGenerateRoute: AppRouter.generateRoute,
          home: BlocSelector<AppUserCubit, AppUserState, bool>(
            selector: (state) => state is AppUserLoggedIn,
            builder: (context, isLoggedIn) {
              return isLoggedIn ? const MainPage() : const LoginPage();
            },
          ),
        );
      },
    );
  }
}

