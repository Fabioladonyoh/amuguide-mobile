import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';

import 'widgets/procedure_tile.dart';

class ProceduresScreen extends StatelessWidget {
  const ProceduresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),

          child: Column(
            children: [

              // HEADER
              Container(
                height: 120,
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  children: [

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: const Icon(
                        Icons.arrow_back,
                        size: 38,
                        color: Colors.black,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      child: const Text(
                        'Procédures AMU',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // TITRE
              const Text(
                'Comprendre les démarches AMU',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Consultez les étapes pour utiliser votre\nassurance facilement',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 42),

              // PROCEDURES
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24),

                child: Column(
                  children: [

                    ProcedureTile(
                     image: AppAssets.amuCard,
                      title: 'Utiliser ma carte AMU',
                      subtitle:
                          'Comment bénéficier des soins',
                    ),

                    ProcedureTile(
                      image: AppAssets.cross,
                      title:
                          'Se rendre dans un centre agréé',
                      subtitle:
                          'Choisir un hôpital ou une\npharmacie reconnue',
                    ),

                    ProcedureTile(
                      image: AppAssets.stethoscope,
                      title:
                          'Conditions de prise en charge',
                      subtitle:
                          'Vérifier les conditions selon le soin',
                    ),

                    ProcedureTile(
                      image: AppAssets.money,
                      title:
                          'Paiement et remboursement',
                      subtitle:
                          'Comprendre ce que vous devez payer',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 46),

              // INFO
              const Text(
                'Besoin de plus d’informations ?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Poser Une Question Au Chatbot',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 36),

              // BOUTON CHATBOT
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20),

                child: Container(
                  height: 110,

                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius:
                        BorderRadius.circular(55),
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
                          Icons
                              .keyboard_double_arrow_right,
                          color: AppColors.blue,
                          size: 38,
                        ),
                      ),

                      const SizedBox(width: 22),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}