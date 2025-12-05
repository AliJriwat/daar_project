import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/colors.dart';
import '../../bloc/profile_bloc.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(top: 16, left: 20, bottom: 6),
    alignment: Alignment.centerLeft,
    child: Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        color: AppColors.grey,
        letterSpacing: 1,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget buildProfileOption({
  required BuildContext context,
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return ListTile(
    onTap: onTap,
    leading: Icon(icon, color: Theme.of(context).iconTheme.color),
    title: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    ),
    trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
  );
}

Widget buildDarkModeOption({
  required BuildContext context,
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  final isDark = context.watch<ProfileBloc>().state.themeMode == ThemeMode.dark;

  return ListTile(
    onTap: onTap,
    leading: Icon(icon, color: Theme.of(context).iconTheme.color),
    title: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    ),
    trailing: Switch(
      value: isDark,
      onChanged: (_) => onTap(),
      activeColor: Theme.of(context).colorScheme.primary,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
  );
}


Widget buildDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Divider(color: Colors.grey.shade300, height: 10),
  );
}
