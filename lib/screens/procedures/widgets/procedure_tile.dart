import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class ProcedureTile extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const ProcedureTile({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 110,
            decoration: BoxDecoration(
              color: const Color(0xFF84E291),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Image.asset(
                image,
                width: 55,
                height: 55,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 38,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}