import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/verification_provider.dart';
import 'verification_result_screen.dart';
import 'widgets/verification_chip.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  Future<void> searchAndOpen(BuildContext context, String motCle) async {
    final provider = context.read<VerificationProvider>();

    await provider.search(motCle);

    if (provider.prestations.isNotEmpty && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              VerificationResultScreen(prestation: provider.prestations.first),
        ),
      );
    } else if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Aucun soin trouve')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VerificationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 28),
              const Text(
                'Verifiez la prise en charge',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 14),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  'Entrez un soin pour savoir s il est couvert par l AMU',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
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
              const SizedBox(height: 54),
              if (provider.isLoading)
                const CircularProgressIndicator()
              else
                Container(
                  height: 54,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
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
                      const Icon(Icons.search, size: 26, color: Colors.black),
                      const SizedBox(width: 16),
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
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 14,
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
              'Verifier un soin',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Spacer(),
          const SizedBox(width: 38),
        ],
      ),
    );
  }
}
