import 'package:daar_project/features/profile/presentation/pages/about/about_page.dart';
import 'package:daar_project/features/profile/presentation/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import '../../features/profile/presentation/pages/edit_profile/edit_profile_page.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case RouteNames.about:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
