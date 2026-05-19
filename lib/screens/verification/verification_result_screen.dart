import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../models/prestation.dart';
import 'widgets/verification_result_card.dart';

class VerificationResultScreen extends StatelessWidget {
  final Prestation prestation;

  const VerificationResultScreen({
    super.key,
    required this.prestation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 150),
              VerificationResultCard(prestation: prestation),
              const SizedBox(height: 105),
              const Text(
                'Besoin de plus d’informations ?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 38),
              ),
              const SizedBox(height: 42),
              const Text(
                'Poser Une Question Au Chatbot',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 42),
              _chatbotButton(context),
            ],
          ),
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
            child: const Icon(Icons.arrow_back, size: 38),
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
              style: TextStyle(fontSize: 28),
            ),
          ),
          const Spacer(),
          const SizedBox(width: 38),
        ],
      ),
    );
  }

  Widget _chatbotButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(55),
        ),
        child: Row(
          children: [
            const SizedBox(width: 24),
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  AppAssets.chatbotSmall,
                  width: 38,
                  height: 38,
                ),
              ),
            ),
            const SizedBox(width: 18),
            const Expanded(
              child: Text(
                'Posez Votre Question Au\nChatbot',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  height: 1.1,
                ),
              ),
            ),
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.keyboard_double_arrow_right,
                color: AppColors.blue,
                size: 34,
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}