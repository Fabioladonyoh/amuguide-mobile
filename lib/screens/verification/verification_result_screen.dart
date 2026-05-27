import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../models/prestation.dart';
import '../chatbot/chatbot_screen.dart';
import 'widgets/verification_result_card.dart';

class VerificationResultScreen extends StatelessWidget {
  final Prestation prestation;

  const VerificationResultScreen({super.key, required this.prestation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 72),
              VerificationResultCard(prestation: prestation),
              const SizedBox(height: 42),
              const Text(
                'Besoin de plus d’informations ?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 18),
              const Text(
                'Poser Une Question Au Chatbot',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 22),
              _chatbotButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 74,
      color: const Color(0xFFF3F3F3),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, size: 26),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Vérifier un soin',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Spacer(),
          const SizedBox(width: 26),
        ],
      ),
    );
  }

  Widget _chatbotButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatbotScreen()),
          );
        },
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppAssets.chatbotSmall,
                    width: 22,
                    height: 22,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Posez Votre Question Au\nChatbot',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.1,
                  ),
                ),
              ),
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.keyboard_double_arrow_right,
                  color: AppColors.blue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
