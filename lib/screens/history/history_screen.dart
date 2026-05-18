import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import 'widgets/history_card.dart';
import 'widgets/history_item.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 130),
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 36),
              _titleSection(),
              const SizedBox(height: 34),
              HistoryCard(
                items: const [
                  HistoryItem(
                    title: 'Scanner abdominal',
                    time: 'Il y a 5 min',
                  ),
                  HistoryItem(
                    title: 'Consultation générale',
                    time: 'Il y a 10 min',
                  ),
                  HistoryItem(
                    title: 'Consultation générale',
                    time: 'Il y a 10 min',
                  ),
                ],
              ),
              const SizedBox(height: 0),
              HistoryCard(
                items: const [
                  HistoryItem(
                    title: 'Pharmacie proche',
                    time: 'Hier',
                  ),
                  HistoryItem(
                    title: 'Analyse sanguine',
                    time: 'Il y a 1 jours',
                  ),
                  HistoryItem(
                    title: 'Carte assurance',
                    time: 'Il y a 2 jours',
                  ),
                ],
              ),
              const SizedBox(height: 72),
              const Text(
                'Besoin d’aide ?',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Poser Une Question Au Chatbot',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              _chatbotButton(),
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
            child: const Icon(
              Icons.arrow_back,
              size: 38,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'Historique',
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

  Widget _titleSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete_outline,
              size: 42,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Vos dernières recherches',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 18),
          Text(
            'Retrouvez vos questions et demandes récentes',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatbotButton() {
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