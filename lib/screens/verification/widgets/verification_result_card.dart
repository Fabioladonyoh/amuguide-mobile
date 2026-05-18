import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class VerificationResultCard extends StatelessWidget {
  const VerificationResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 42),
          padding: const EdgeInsets.fromLTRB(55, 115, 35, 60),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✓ Pris en charge à 80%',
                style: TextStyle(
                  fontSize: 31,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 38),
              Text(
                'Conditions :\n• Prescription médicale\n• Centre agréé AMU',
                style: TextStyle(
                  fontSize: 31,
                  height: 1.35,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -28,
          child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 45),
            color: AppColors.green,
            child: const Center(
              child: Text(
                'Scanner abdominal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}