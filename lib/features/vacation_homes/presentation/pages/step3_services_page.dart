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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isActive = _services[serviceKey] ?? false;

    return InkWell(
      onTap: () {
        setState(() {
          _services[serviceKey] = !isActive;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.borderColorShade,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: isActive ? AppColors.primary : Theme.of(context).textTheme.bodyLarge?.color,
                ),
                const SizedBox(width: 12),
                Text(
                  serviceName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
            Switch(
              value: isActive,
              onChanged: (value) {
                setState(() {
                  _services[serviceKey] = value;
                });
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
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

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onNext(_services);
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              child: Text(
                'next'.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}