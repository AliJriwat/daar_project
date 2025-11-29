import 'package:daar_project/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:daar_project/core/common/app_user/app_user_cubit.dart';
import '../../../../app/routes/route_names.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_widgets.dart';
import 'package:daar_project/features/auth/presentation/bloc/auth_bloc.dart';

class _LanguagePickerSheet extends StatelessWidget {
  final List<Map<String, dynamic>> languages = [
    {"locale": Locale('en'), "label": "English / إنجليزي", "flag": "🇬🇧"},
    {"locale": Locale('it'), "label": "Italian / إيطالي", "flag": "🇮🇹"},
    {"locale": Locale('ar'), "label": "Arabic / عربي", "flag": "🇱🇾"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentLocale = context.locale;
    Locale selectedLocale = currentLocale;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // --- TITOLO ---
              Text(
                "Select Language",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // --- LISTA LINGUE ---
              ...languages.map((lang) {
                final locale = lang["locale"] as Locale;
                final label = lang["label"];
                final flag = lang["flag"];

                return RadioListTile<Locale>(
                  value: locale,
                  groupValue: selectedLocale,
                  activeColor: theme.colorScheme.primary,
                  title: Row(
                    children: [
                      Text(flag, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 10),
                      Text(label, style: theme.textTheme.bodyLarge),
                    ],
                  ),
                  onChanged: (val) {
                    setState(() {
                      selectedLocale = val!;
                    });
                  },
                );
              }).toList(),

              const SizedBox(height: 10),

              // --- BOTTONE APPLY ---
              // --- BOTTONE APPLY ---
              GestureDetector(
                onTap: () async {
                  context.read<ProfileBloc>().add(ChangeLanguage(selectedLocale));
                  await context.setLocale(selectedLocale);
                  Navigator.pop(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Apply",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(AuthLogout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr(), style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (context, state) {
          if (state is AppUserLoggedIn) {
            final user = state.user;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Header con avatar, nome ed email
                    ProfileHeader(
                      username: user.name,
                      email: user.email,
                    ),
                    const SizedBox(height: 30),
                    // Logout
                    Container(
                      decoration: BoxDecoration(
                        color: context.watch<ProfileBloc>().state.themeMode == ThemeMode.dark
                            ? AppColors.black
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          buildSectionHeader("preferences".tr()),
                          buildProfileOption(
                            context: context,
                            icon: Icons.edit,
                            text: "edit_profile".tr(),
                            onTap: () {
                              Navigator.pushNamed(context, RouteNames.editProfile);
                            },
                          ),
                          buildProfileOption(
                            context: context,
                            icon: Icons.location_on,
                            text: "my_addresses".tr(),
                            onTap: () {
                              Navigator.pushNamed(context, RouteNames.myAddresses);
                            },
                          ),
                          buildProfileOption(
                              context: context,
                              icon: Icons.business_center,
                              text: "partner_mode".tr(),
                              onTap: () {}
                          ),
                          buildDivider(),
                          buildSectionHeader("settings2".tr()),
                          buildProfileOption(
                            context: context,
                            icon: Icons.settings,
                            text: "settings".tr(),
                            onTap: () {
                              Navigator.pushNamed(context, RouteNames.settings);
                            },
                          ),
                          buildProfileOption(
                            context: context,
                            icon: Icons.language,
                            text: "language".tr(),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (_) => _LanguagePickerSheet(),
                              );
                            },
                          ),

                          buildDarkModeOption(
                            context: context,
                            icon: Icons.nightlight_round,
                            text: "dark_mode".tr(),
                            onTap: () {
                              context.read<ProfileBloc>().add(ToggleTheme());
                            },
                          ),
                          buildDivider(),
                          buildSectionHeader("support".tr()),
                          buildProfileOption(
                            context: context,
                            icon: Icons.info,
                            text: "about".tr(),
                            onTap: () {
                              Navigator.pushNamed(context, RouteNames.about);
                            },
                          ),
                          buildProfileOption(
                            context: context,
                            icon: Icons.help,
                            text: "help_center".tr(),
                            onTap: () {},
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: ElevatedButton.icon(
                              onPressed: () => _logout(context),
                              icon: const Icon(Icons.logout, color: Colors.white),
                              label: Text(
                                "logout".tr(),
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}