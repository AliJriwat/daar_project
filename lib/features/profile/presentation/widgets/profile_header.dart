import 'package:flutter/material.dart';
import '../../../../app/theme/colors.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String email;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                username,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        /*
        const SizedBox(height: 20),
        Text('username', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(username, style: theme.textTheme.titleLarge),
        const SizedBox(height: 20),
        Text('email', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(email, style: theme.textTheme.titleLarge),
        */
        /*
        * Text(
                        username,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: const TextStyle(color: Colors.grey, fontSize: 15),
                      ),
        * */
      ],
    );
  }
}
