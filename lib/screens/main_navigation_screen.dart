import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_assets.dart';

import 'home/home_screen.dart';
import 'chatbot/chatbot_screen.dart';
import 'structures/structures_screen.dart';
import 'history/history_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    ChatbotScreen(),
    StructuresScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        height: 105,
        decoration: const BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              label: 'Accueil',
              iconPath: AppAssets.home,
              isActive: currentIndex == 0,
              onTap: () => changePage(0),
            ),
            _NavItem(
              label: 'Chat',
              iconPath: AppAssets.chatbotWhite,
              isActive: currentIndex == 1,
              onTap: () => changePage(1),
            ),
            _NavItem(
              label: 'Carte',
              iconPath: AppAssets.map,
              isActive: currentIndex == 2,
              onTap: () => changePage(2),
            ),
            _NavItem(
              label: 'Historique',
              iconPath: AppAssets.history,
              isActive: currentIndex == 3,
              onTap: () => changePage(3),
            ),
            _NavIconOnly(
              label: 'Profil',
              icon: Icons.person,
              isActive: currentIndex == 4,
              onTap: () => changePage(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? AppColors.white : Colors.white54;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 32,
              color: color,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.circle, color: color, size: 30);
              },
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIconOnly extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIconOnly({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? AppColors.white : Colors.white54;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 34),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}