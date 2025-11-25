import 'package:daar_project/features/profile/domain/entities/settings.dart';
import 'package:daar_project/features/profile/domain/repositories/settings_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SupabaseClient supabase;

  SettingsRepositoryImpl(this.supabase);

  @override
  Future<Settings> getSettings(String userId) async {
    try {
      final response = await supabase
          .from('user_settings')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (response == null) {
        // 🆕 CREA AUTOMATICAMENTE LA RIGA SE NON ESISTE
        final defaultSettings = _createDefaultSettings(userId);
        await updateSettings(defaultSettings); // 🆕 SALVA NEL DB
        return defaultSettings;
      }

      return Settings(
        userId: userId,
        currency: response['currency'] ?? 'EUR',
        updatedAt: DateTime.parse(response['updated_at']),
      );
    } catch (e) {
      debugPrint("Errore nel getSettings: $e");
      // 🆕 ANCHE IN CASO DI ERRORE, CREA LA RIGA
      final defaultSettings = _createDefaultSettings(userId);
      await updateSettings(defaultSettings);
      return defaultSettings;
    }
  }

  Settings _createDefaultSettings(String userId) {
    return Settings(
      userId: userId,
      currency: 'EUR', // 🆕 O 'LD' se preferisci
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
        });
  }
}