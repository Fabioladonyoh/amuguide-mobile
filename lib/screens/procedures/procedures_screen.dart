import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../models/prestation.dart';
import '../../providers/prestation_provider.dart';
import '../chatbot/chatbot_screen.dart';
import 'widgets/procedure_tile.dart';

class ProceduresScreen extends StatefulWidget {
  const ProceduresScreen({super.key});

  @override
  State<ProceduresScreen> createState() => _ProceduresScreenState();
}

class _ProceduresScreenState extends State<ProceduresScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PrestationProvider>().loadPrestations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PrestationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 36),
              const Text(
                'Prestations AMU',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              const Text(
                'Consultez les actes couverts et leurs\nconditions de prise en charge',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(height: 42),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _prestationList(provider),
              ),
              const SizedBox(height: 46),
              const Text(
                'Besoin de plus d informations ?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              const Text(
                'Poser Une Question Au Chatbot',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 36),
              _chatbotButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: const Icon(Icons.arrow_back, size: 38, color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Procedures AMU',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _prestationList(PrestationProvider provider) {
    if (provider.isLoading && provider.prestations.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: CircularProgressIndicator(),
      );
    }

    if (provider.prestations.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Text(
          'Aucune prestation disponible',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      );
    }

    return Column(
      children: provider.prestations.map(_tileFromPrestation).toList(),
    );
  }

  ProcedureTile _tileFromPrestation(Prestation prestation) {
    final taux = prestation.tauxCouverture.round();
    final subtitle = prestation.prisEnCharge
        ? 'Couverture $taux% - ${prestation.conditionsPriseEnCharge}'
        : 'Non pris en charge - ${prestation.conditionsPriseEnCharge}';

    return ProcedureTile(
      image: _imageForCategorie(prestation.categorie),
      title: prestation.nomActe,
      subtitle: subtitle,
    );
  }

  Widget _chatbotButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatbotScreen()),
          );
        },
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(55),
          ),
          child: Row(
            children: [
              const SizedBox(width: 22),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppAssets.chatbotSmall,
                    width: 42,
                    height: 42,
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
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.keyboard_double_arrow_right,
                  color: AppColors.blue,
                  size: 38,
                ),
              ),
              const SizedBox(width: 22),
            ],
          ),
        ),
      ),
    );
  }

  String _imageForCategorie(String categorie) {
    switch (categorie) {
      case 'MEDICAMENT':
        return AppAssets.cross;
      case 'HOSPITALISATION':
      case 'CHIRURGIE':
        return AppAssets.amuCard;
      case 'RADIOLOGIE':
      case 'BIOLOGIE':
      case 'CONSULTATION':
      default:
        return AppAssets.stethoscope;
    }
  }
}
