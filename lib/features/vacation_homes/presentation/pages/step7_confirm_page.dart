// lib/features/vacation_homes/presentation/pages/add_vacation_home/step3_services_page.dart

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:daar_project/app/theme/colors.dart';

class Step3ServicesPage extends StatefulWidget {
  final Function(Map<String, bool> services) onNext;
  final VoidCallback onBack;
  final Map<String, bool> initialServices;

  const Step3ServicesPage({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.initialServices,
  });

  @override
  State<Step3ServicesPage> createState() => _Step3ServicesPageState();
}

class _Step3ServicesPageState extends State<Step3ServicesPage> {
  late Map<String, bool> _services;

  @override
  void initState() {
    super.initState();
    _services = Map<String, bool>.from(widget.initialServices);
  }

  Widget _buildServiceSwitch(String serviceKey, String serviceName, IconData icon) {
    return Card(
      child: SwitchListTile(
        title: Row(
          children: [
            Icon(icon, color: Theme.of(context).textTheme.bodyLarge?.color),
            const SizedBox(width: 12),
            Text(serviceName),
          ],
        ),
        value: _services[serviceKey] ?? false,
        onChanged: (value) {
          setState(() {
            _services[serviceKey] = value;
          });
        },
        activeColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'services'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'select_services'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),

          // Lista servizi
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildServiceSwitch('pool', 'Pool', Icons.pool),
                  _buildServiceSwitch('wifi', 'Wi-Fi', Icons.wifi),
                  _buildServiceSwitch('parking', 'Parking', Icons.local_parking),
                  _buildServiceSwitch('air_conditioning', 'Air Conditioning', Icons.ac_unit),
                  _buildServiceSwitch('pet_friendly', 'Pet Friendly', Icons.pets),
                  _buildServiceSwitch('barbecue', 'Barbecue', Icons.outdoor_grill),
                  _buildServiceSwitch('sea_access', 'Sea Access', Icons.beach_access),
                  _buildServiceSwitch('outdoor_shower', 'Outdoor Shower', Icons.shower),
                  _buildServiceSwitch('spa', 'Spa', Icons.spa),
                  _buildServiceSwitch('tv', 'TV', Icons.tv),
                  _buildServiceSwitch('sports_equipment', 'Sports Equipment', Icons.sports_baseball),
                  _buildServiceSwitch('outdoor_kitchen', 'Outdoor Kitchen', Icons.kitchen),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Bottoni
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onBack,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                    side: BorderSide(
                      color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.grey,
                    ),
                  ),
                  child: Text('back'.tr()),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onNext(_services);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'next'.tr(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}