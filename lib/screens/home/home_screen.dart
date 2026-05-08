/*import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Center(
        child: Text('Accueil'),
      ),

    );
  }
} */



import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 25),
              _welcomeText(),
              const SizedBox(height: 24),
              _chatbotButton(),
              const SizedBox(height: 28),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Nos Fonctionnalités',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              _featuresSection(),
              const SizedBox(height: 34),
              _structuresTitle(),
              const SizedBox(height: 16),
              _structuresList(),
              const SizedBox(height: 34),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Questions fréquentes',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _faqSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 150,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Row(
        children: [
          Image.asset(
            AppAssets.logo,
            width: 285,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 42,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _welcomeText() {
    return const Center(
      child: Column(
        children: [
          Text(
            'Bienvenue,',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            'Comment Pouvons-Nous Vous Aider ?',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatbotButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  fontSize: 25,
                  height: 1.08,
                  fontWeight: FontWeight.w400,
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
                size: 36,
              ),
            ),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  Widget _featuresSection() {
    return SizedBox(
      height: 210,
      child: Stack(
        children: [
          Positioned(
            top: 38,
            left: 0,
            right: 0,
            child: Container(
              height: 160,
              color: AppColors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _featureCard(
                        image: AppAssets.chatbot,
                        title: 'Chatbot',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 26),
                    Expanded(
                      child: _featureCard(
                        image: AppAssets.stethoscope,
                        title: 'Vérifier',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: _featureCard(
                        image: AppAssets.cross,
                        title: 'Structures',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 26),
                    Expanded(
                      child: _featureCard(
                        image: AppAssets.procedure,
                        title: 'Procédures',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 86,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: Color(0x25000000),
              blurRadius: 8,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 58,
              height: 58,
              fit: BoxFit.contain,
            ),

            const SizedBox(width: 12),

            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.blue,
                  fontSize: 29,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _structuresTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            'Structures proches',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Text(
            'Voir tout →',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _structuresList() {
    return SizedBox(
      height: 255,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          return _structureCard();
        },
      ),
    );
  }

  Widget _structureCard() {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x30000000),
            blurRadius: 7,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppAssets.hospitalCard,
              height: 135,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Hôpital CHU',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const Text(
            'Sylvanus Olympio',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Text(
                '1.2 km',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Container(
                width: 85,
                height: 34,
                color: AppColors.green,
                child: const Center(
                  child: Text(
                    'Voir carte',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _faqSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _faqButton('Quels soins sont couverts ?')),
              const SizedBox(width: 60),
              Expanded(child: _faqButton('Trouver une pharmacie')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _faqButton('Comment utiliser ma carte ?')),
              const SizedBox(width: 60),
              Expanded(child: _faqButton('Quels soins sont couverts ?')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _faqButton(String text) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.keyboard_arrow_down, size: 28, color: Colors.black),
      ],
    );
  }
}