import 'package:daar_project/features/profile/presentation/pages/settings/widgets/settings_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../init_dependencies.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedCurrency = "EUR"; // default iniziale
  final supabase = serviceLocator<SupabaseClient>();

  @override
  void initState() {
    super.initState();
    _loadCurrency();
  }

  Future<void> _loadCurrency() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final response = await supabase
        .from('user_settings')
        .select('currency')
        .eq('user_id', user.id)
        .maybeSingle(); // response è PostgrestMap? ora

    setState(() {
      selectedCurrency = response?['currency'] ?? 'EUR';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildSettingsOption(
            context: context,
            text: "currency",
            trailingText: selectedCurrency,
            onTap: () {
              final user = supabase.auth.currentUser;
              if (user == null) return;

              showCurrencyPicker(context, ["USD", "EUR", "GBP", "LD"], (currency) async {
                // Aggiorna lo stato locale
                setState(() {
                  selectedCurrency = currency;
                });

                // Salva su Supabase nella tabella user_settings
                final response = await supabase.from('user_settings').update({
                  'currency': currency,
                }).eq('user_id', user.id);

                if (response.error != null) {
                  debugPrint("Errore: ${response.error!.message}");
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
