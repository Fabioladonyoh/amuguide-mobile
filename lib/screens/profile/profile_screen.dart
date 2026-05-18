import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 30, 22, 130),
          child: Column(
            children: [
              _profileHeader(),
              const SizedBox(height: 35),
              _profileCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 105,
              height: 105,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue,
              ),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.profileAvatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 5,
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 22,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DONYOH Fabiola',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'fabioladonyoh283@gmail.com',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF5E8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.green,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Assuré AMU actif',
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 30, 22, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x25000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _quickAction(
                icon: Icons.add,
                label: 'Modifier\nprofil',
                color: AppColors.green,
              ),
              _quickAction(
                icon: Icons.history,
                label: 'Historique',
                color: AppColors.blue,
              ),
              _quickAction(
                icon: Icons.assignment,
                label: 'Procédures\nAMU',
                color: AppColors.blue,
              ),
            ],
          ),

          const SizedBox(height: 28),
          const Divider(color: Colors.black, thickness: 1),

          _menuItem(Icons.language, 'Langue'),
          _menuItem(Icons.location_on_outlined, 'Adresse'),
          _menuItem(Icons.phone_in_talk_outlined, 'Téléphone'),
          _menuItem(Icons.flag_circle_outlined, 'Pays'),

          const Divider(color: Colors.black, thickness: 1),

          _menuItem(Icons.headset_mic_outlined, 'Contacter le support'),
          _menuItem(Icons.logout, 'Se déconnecter'),
        ],
      ),
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 27,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            height: 1.15,
          ),
        ),
      ],
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 19),
      child: Row(
        children: [
          Icon(
            icon,
            size: 36,
            color: Colors.black,
          ),
          const SizedBox(width: 42),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 34,
            color: Colors.black,
          ),
        ],
      ),
      
    );
  }
}