import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/prestation.dart';

class VerificationResultCard extends StatelessWidget {
  final Prestation prestation;

  const VerificationResultCard({super.key, required this.prestation});

  @override
  Widget build(BuildContext context) {
    final int taux = _normalizedTaux(prestation.tauxCouverture);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 48),
          padding: const EdgeInsets.fromLTRB(22, 58, 22, 28),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 1.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prestation.prisEnCharge
                    ? '✓ Pris en charge à $taux%'
                    : '✕ Non pris en charge',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 18),
              Text(
                'Conditions :\n${_asBulletText(prestation.conditionsPriseEnCharge)}',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.25,
                  color: Colors.black87,
                ),
              ),
              if (prestation.documentsRequis.trim().isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Documents :\n${_asBulletText(prestation.documentsRequis)}',
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.25,
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        ),
        Positioned(
          top: -14,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 250),
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            color: AppColors.green,
            child: Center(
              child: Text(
                prestation.nomActe,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  int _normalizedTaux(double value) {
    if (value <= 1) {
      return (value * 100).round();
    }
    return value.round();
  }

  String _asBulletText(String value) {
    final cleaned = value.trim();
    if (cleaned.isEmpty) {
      return '• Non precise';
    }

    return cleaned
        .split(RegExp(r'[,;]\s*'))
        .where((part) => part.trim().isNotEmpty)
        .map((part) => '• ${part.trim()}')
        .join('\n');
  }
}
