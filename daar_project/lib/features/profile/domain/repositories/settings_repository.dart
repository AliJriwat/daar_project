import '../entities/settings.dart';

abstract class SettingsRepository {
  Future<Settings> getSettings(String userId);
  Future<void> updateSettings(Settings settings);
}