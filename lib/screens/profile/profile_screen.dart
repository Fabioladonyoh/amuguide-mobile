import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../models/assure_profile.dart';
import '../../providers/auth_provider.dart';
import '../../providers/demande_provider.dart';
import '../../providers/profile_provider.dart';
import '../auth/login_screen.dart';
import '../contact/contact_support_screen.dart';
import '../history/history_screen.dart';
import '../procedures/procedures_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthProvider>();
      context.read<ProfileProvider>().loadProfile(
        token: auth.token,
        nom: auth.nom,
        prenom: auth.prenom,
        identifiant: auth.identifiant,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final auth = context.watch<AuthProvider>();
    final profile =
        provider.profile ??
        AssureProfile.fallback(
          nom: auth.nom ?? '',
          prenom: auth.prenom ?? '',
          identifiant: auth.identifiant ?? '',
        );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 30, 22, 130),
          child: Column(
            children: [
              if (provider.isLoading)
                const LinearProgressIndicator(minHeight: 3),
              _profileHeader(profile),
              const SizedBox(height: 35),
              _profileCard(context, profile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader(AssureProfile profile) {
    final email = profile.email.isEmpty ? profile.numeroAMU : profile.email;
    final isActif = profile.statut.toUpperCase() == 'ACTIF';

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
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF2FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 68,
                  color: AppColors.blue,
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
              Text(
                profile.fullName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                email,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: isActif
                      ? const Color(0xFFDFF5E8)
                      : const Color(0xFFFFECEC),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isActif ? Icons.check_circle : Icons.info_outline,
                      color: isActif ? AppColors.green : Colors.red,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isActif ? 'Assure AMU actif' : 'Statut ${profile.statut}',
                      style: TextStyle(
                        color: isActif ? AppColors.green : Colors.red,
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

  Widget _profileCard(BuildContext context, AssureProfile profile) {
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
                onTap: () => _showInfo(
                  'Modifier mon profil',
                  'La modification du profil se fait par le support AMU pour garder les informations assurees fiables.',
                ),
              ),
              _quickAction(
                icon: Icons.history,
                label: 'Historique',
                color: AppColors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryScreen()),
                  );
                },
              ),
              _quickAction(
                icon: Icons.assignment,
                label: 'Procedures\nAMU',
                color: AppColors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProceduresScreen()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Divider(color: Colors.black, thickness: 1),
          _menuItem(
            Icons.badge_outlined,
            _valueOrFallback(profile.numeroAMU, 'Numero AMU'),
            onTap: () => _showInfo(
              'Numero AMU',
              _valueOrFallback(profile.numeroAMU, 'Numero AMU non renseigne'),
            ),
          ),
          _menuItem(
            Icons.location_on_outlined,
            _valueOrFallback(profile.adresse, 'Adresse'),
            onTap: () => _showInfo(
              'Adresse',
              _valueOrFallback(profile.adresse, 'Adresse non renseignee'),
            ),
          ),
          _menuItem(
            Icons.phone_in_talk_outlined,
            _valueOrFallback(profile.telephone, 'Telephone'),
            onTap: () => _showInfo(
              'Telephone',
              _valueOrFallback(profile.telephone, 'Telephone non renseigne'),
            ),
          ),
          _menuItem(
            Icons.flag_circle_outlined,
            'Togo',
            onTap: () => _showInfo('Pays', 'Togo'),
          ),
          const Divider(color: Colors.black, thickness: 1),
          _menuItem(
            Icons.headset_mic_outlined,
            'Contacter le support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContactSupportScreen(profile: profile),
                ),
              );
            },
          ),
          _menuItem(
            Icons.logout,
            'Se deconnecter',
            onTap: () async {
              context.read<ProfileProvider>().clear();
              context.read<DemandeProvider>().clear();
              await context.read<AuthProvider>().logout();

              if (!context.mounted) {
                return;
              }

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
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
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 27),
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
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 19),
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.black),
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
            const Icon(Icons.chevron_right, size: 34, color: Colors.black),
          ],
        ),
      ),
    );
  }

  String _valueOrFallback(String value, String fallback) {
    return value.trim().isEmpty ? fallback : value;
  }

  void _showInfo(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
