import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'verification_result_screen.dart';
import 'widgets/verification_chip.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  void openResult(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const VerificationResultScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            const SizedBox(height: 52),
            const Text(
              'Vérifiez la prise en charge',
              style: TextStyle(
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Entrez un soin pour savoir s’il est couvert par l’AMU',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 58),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerificationChip(
                    label: 'Scanner',
                    onTap: () => openResult(context),
                  ),
                  VerificationChip(
                    label: 'Analyse',
                    onTap: () => openResult(context),
                  ),
                  VerificationChip(
                    label: 'Consultation',
                    onTap: () => openResult(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 82),
            GestureDetector(
              onTap: () => openResult(context),
              child: Container(
                height: 84,
                margin: const EdgeInsets.symmetric(horizontal: 38),
                padding: const EdgeInsets.symmetric(horizontal: 34),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x20000000),
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 44, color: Colors.black),
                    SizedBox(width: 22),
                    Text(
                      'Ex: scanner, consultation, analyse...',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 110,
      color: const Color(0xFFF3F3F3),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              size: 38,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'Vérifier un soin',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(),
          const SizedBox(width: 38),
        ],
      ),
    );
  }
}