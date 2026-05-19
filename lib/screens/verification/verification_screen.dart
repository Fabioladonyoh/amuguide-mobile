import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/verification_provider.dart';
import 'verification_result_screen.dart';
import 'widgets/verification_chip.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  Future<void> searchAndOpen(
    BuildContext context,
    String motCle,
  ) async {
    final provider = context.read<VerificationProvider>();

    await provider.search(motCle);

    if (provider.prestations.isNotEmpty && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VerificationResultScreen(
            prestation: provider.prestations.first,
          ),
        ),
      );
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucun soin trouvé'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VerificationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            const SizedBox(height: 52),
            const Text(
              'Vérifiez la prise en charge',
              style: TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 22),
            const Text(
              'Entrez un soin pour savoir s’il est couvert par l’AMU',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 58),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerificationChip(
                    label: 'Scanner',
                    onTap: () => searchAndOpen(context, 'scanner'),
                  ),
                  VerificationChip(
                    label: 'Analyse',
                    onTap: () => searchAndOpen(context, 'analyse'),
                  ),
                  VerificationChip(
                    label: 'Consultation',
                    onTap: () => searchAndOpen(context, 'consultation'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 82),

            if (provider.isLoading)
              const CircularProgressIndicator()
            else
            Container(
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
  child: Row(
    children: [
      const Icon(Icons.search, size: 44, color: Colors.black),
      const SizedBox(width: 22),
      Expanded(
        child: TextField(
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              searchAndOpen(context, value.trim());
            }
          },
          decoration: const InputDecoration(
            hintText: 'Ex: scanner, consultation, analyse...',
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 22,
              color: Colors.grey,
            ),
          ),
          style: const TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
    ],
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
}