import 'package:flutter/material.dart';

import '../../../../../../app/theme/colors.dart';

Widget buildAddressTextField({
  required TextEditingController controller,
  required String hintText,
  bool isDescription = false,
}) {
  return TextField(
    controller: controller,
    maxLines: isDescription ? 4 : 1,
    decoration: InputDecoration(
      hintText: hintText,

      hintStyle: TextStyle(color: Colors.grey[600]),

      contentPadding: EdgeInsets.symmetric(
        vertical: isDescription ? 22 : 16,
        horizontal: 16,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

Widget buildAddressButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        //padding: const EdgeInsets.symmetric(horizontal: 25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    ),
  );
}