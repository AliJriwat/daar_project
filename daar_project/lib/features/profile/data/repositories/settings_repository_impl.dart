import 'package:daar_project/features/profile/domain/entities/settings.dart';
import 'package:daar_project/features/profile/domain/repositories/settings_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SupabaseClient supabase;

  SettingsRepositoryImpl(this.supabase);

  @override
  Future<Settings> getSettings(String userId) async {
    final response = await supabase
        .from('user_setings')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) {
      return _createDefaultSettings(userId);
    }

    return Settings(
      userId: userId,
      currency: response['currency'],
      updatedAt: DateTime.parse(response['updated_at']),
    );
  }

  Settings _createDefaultSettings(String userId) {
    return Settings(
      userId: userId,
      currency: 'LD',
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    await supabase
        .from('user_settings')
        .upsert({
          'user_id' : settings.userId,
          'currency' : settings.currency,
          'updated_at': settings.updatedAt.toIso8601String(),
        })
        .select()
        .single();
  }
}