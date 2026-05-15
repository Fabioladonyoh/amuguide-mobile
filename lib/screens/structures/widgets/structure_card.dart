import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class StructureCard extends StatelessWidget {
  const StructureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x25000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              AppAssets.hospitalCard,
              width: double.infinity,
              height: 260,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 22),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hôpital CHU',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(text: ' , Sylvanus Olympio'),
              ],
            ),
            style: TextStyle(
              fontSize: 27,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              const Text(
                '1.2 km / 50 min',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Container(
                height: 58,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                color: AppColors.green,
                child: const Center(
                  child: Text(
                    'Voir carte',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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