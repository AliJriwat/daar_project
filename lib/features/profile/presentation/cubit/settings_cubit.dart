// features/profile/presentation/cubit/settings_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  final String userId;

  SettingsCubit({
    required this.settingsRepository,
    required this.userId,
  }) : super(SettingsInitial());

  Future<void> loadSettings() async {
    emit(SettingsLoading());

    try {
      final settings = await settingsRepository.getSettings(userId);
      emit(SettingsLoaded(settings));
    } catch (e) {
      emit(SettingsError('Failed to load settings: $e'));
    }
  }

  Future<void> updateCurrency(String newCurrency) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return;

    try {
      final updatedSettings = currentState.settings.copyWith(
        currency: newCurrency,
        updatedAt: DateTime.now(),
      );

      await settingsRepository.updateSettings(updatedSettings);
      emit(SettingsLoaded(updatedSettings));
    } catch (e) {
      // Emit error but keep the previous state
      emit(SettingsError('Failed to update currency: $e'));
      // After showing error, return to loaded state
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SettingsLoaded(currentState.settings));
    }
  }
}