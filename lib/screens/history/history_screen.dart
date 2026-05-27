import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../models/demande_response.dart';
import '../../providers/auth_provider.dart';
import '../../providers/demande_provider.dart';
import '../chatbot/chatbot_screen.dart';
import 'widgets/history_card.dart';
import 'widgets/history_item.dart';

class HistoryScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const HistoryScreen({super.key, this.onBack});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = context.read<AuthProvider>().token;
      context.read<DemandeProvider>().loadDemandes(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DemandeProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 125),
          child: Column(
            children: [
              _header(context),
              _titleSection(context),
              _historyContent(provider),
              const SizedBox(height: 28),
              const Text(
                'Besoin d aide ?',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              const SizedBox(height: 14),
              const Text(
                'Poser Une Question Au Chatbot',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 18),
              _chatbotButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyContent(DemandeProvider provider) {
    if (provider.isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: CircularProgressIndicator(),
      );
    }

    if (provider.demandes.isEmpty) {
      return const HistoryCard(
        items: [
          HistoryItem(title: 'Aucune recherche recente', time: ''),
        ],
      );
    }

    final recent = provider.demandes.take(6).toList();
    final firstGroup = recent.take(3).map(_toHistoryItem).toList();
    final secondGroup = recent.skip(3).map(_toHistoryItem).toList();

    return Column(
      children: [
        HistoryCard(items: firstGroup),
        if (secondGroup.isNotEmpty) HistoryCard(items: secondGroup),
      ],
    );
  }

  HistoryItem _toHistoryItem(DemandeResponse demande) {
    return HistoryItem(title: demande.title, time: demande.relativeTime);
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 74,
      color: const Color(0xFFF3F3F3),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.onBack != null) {
                widget.onBack!();
              } else if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: const Icon(Icons.arrow_back, size: 26, color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Text(
              'Historique',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          const Spacer(),
          const SizedBox(width: 26),
        ],
      ),
    );
  }

  Widget _titleSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                context.read<DemandeProvider>().clearDemandesOnly();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Historique efface.')),
                );
              },
              child: const Icon(
                Icons.delete_outline,
                size: 26,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Vos dernieres recherches',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 12),
          const Text(
            'Retrouvez vos questions et demandes recentes',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _chatbotButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatbotScreen()),
          );
        },
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppAssets.chatbotSmall,
                    width: 23,
                    height: 23,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Posez Votre Question Au Chatbot',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.1,
                  ),
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.keyboard_double_arrow_right,
                  color: AppColors.blue,
                  size: 25,
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
