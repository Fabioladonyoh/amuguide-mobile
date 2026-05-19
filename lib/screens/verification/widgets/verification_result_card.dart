import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/prestation.dart';

class VerificationResultCard extends StatelessWidget {

  final Prestation prestation;

  const VerificationResultCard({
    super.key,
    required this.prestation,
  });

  @override
  Widget build(BuildContext context) {

    final int taux =
        (prestation.tauxCouverture * 100).round();

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [

        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 42,
          ),
          padding: const EdgeInsets.fromLTRB(
            55,
            115,
            35,
            60,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                prestation.prisEnCharge
                    ? '✓ Pris en charge à $taux%'
                    : '✕ Non pris en charge',

                style: const TextStyle(
                  fontSize: 31,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 38),

              Text(
                'Conditions :\n'
                '${prestation.conditionsPriseEnCharge}\n\n'
                'Documents :\n'
                '${prestation.documentsRequis}',

                style: const TextStyle(
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
            padding: const EdgeInsets.symmetric(
              horizontal: 45,
            ),

            color: AppColors.green,

            child: Center(
              child: Text(
                prestation.nomActe,

                style: const TextStyle(
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