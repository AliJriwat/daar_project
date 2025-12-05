import 'package:daar_project/features/profile/presentation/pages/settings/widgets/settings_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daar_project/features/profile/presentation/cubit/settings_cubit.dart';

import '../../../../../init_dependencies.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();
    _initializeCubit();
  }

  void _initializeCubit() {
    _settingsCubit = serviceLocator<SettingsCubit>()..loadSettings();
  }

  @override
  void dispose() {
    _settingsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        bloc: _settingsCubit,
        builder: (context, state) {
          return _buildContent(state);
        },
      ),
    );
  }

  Widget _buildContent(SettingsState state) {
    // Gestione stati simile alla logica precedente
    if (state is SettingsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is SettingsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.message}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _settingsCubit.loadSettings,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is SettingsLoaded) {
      return Column(
        children: [
          buildSettingsOption(
            context: context,
            text: "currency",
            trailingText: state.settings.currency,
            onTap: () {
              showCurrencyPicker(context, ["USD", "EUR", "GBP", "LD"], (currency) {
                // Usa il Cubit invece di Supabase diretto
                _settingsCubit.updateCurrency(currency);
              });
            },
          ),
        ],
      );
    }

    // Stato iniziale - carica i settings
    return const Center(child: CircularProgressIndicator());
  }
}