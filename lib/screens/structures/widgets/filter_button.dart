import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;

  const FilterButton({
    super.key,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: isActive ? AppColors.green : AppColors.blue,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}