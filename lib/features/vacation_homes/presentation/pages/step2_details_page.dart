// lib/features/vacation_homes/presentation/pages/add_vacation_home/step2_details_page.dart

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:daar_project/app/theme/colors.dart';

class Step2DetailsPage extends StatefulWidget {
  final Function(int guests, int bedrooms, int beds, int bathrooms) onNext;
  final VoidCallback onBack;

  const Step2DetailsPage({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<Step2DetailsPage> createState() => _Step2DetailsPageState();
}

class _Step2DetailsPageState extends State<Step2DetailsPage> {
  int _maxGuests = 1;
  int _bedrooms = 1;
  int _beds = 1;
  int _bathrooms = 1;

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderColorShade,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          Row(
            children: [
              _roundButton(
                icon: Icons.remove,
                enabled: value > 1,
                onTap: () => onChanged(value - 1),
              ),

              const SizedBox(width: 14),

              Text(
                value.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(width: 14),

              _roundButton(
                icon: Icons.add,
                enabled: true,
                onTap: () => onChanged(value + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _roundButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled
              ? AppColors.primary.withOpacity(0.15)
              : Colors.grey.withOpacity(0.2),
        ),
        child: Icon(
          icon,
          size: 20,
          color: enabled
              ? AppColors.primary
              : Colors.grey,
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
            'house_details'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),

          // Contatori
          _buildCounter('max_guests'.tr(), _maxGuests, (value) {
            setState(() => _maxGuests = value);
          }),
          const SizedBox(height: 12),

          _buildCounter('bedrooms'.tr(), _bedrooms, (value) {
            setState(() => _bedrooms = value);
          }),
          const SizedBox(height: 12),

          _buildCounter('beds'.tr(), _beds, (value) {
            setState(() => _beds = value);
          }),
          const SizedBox(height: 12),

          _buildCounter('bathrooms'.tr(), _bathrooms, (value) {
            setState(() => _bathrooms = value);
          }),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onNext(_maxGuests, _bedrooms, _beds, _bathrooms);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              child: Text(
                'next'.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}