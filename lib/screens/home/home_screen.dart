import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../models/prestation.dart';
import '../../models/structure_sante.dart';
import '../../providers/auth_provider.dart';
import '../../providers/prestation_provider.dart';
import '../../providers/structure_provider.dart';
import '../../screens/structures/structures_screen.dart';
import '../chatbot/chatbot_screen.dart';
import '../history/history_screen.dart';
import '../procedures/procedures_screen.dart';
import '../verification/verification_result_screen.dart';
import '../verification/verification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StructureProvider>().loadStructures();
      context.read<PrestationProvider>().loadPrestations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final structureProvider = context.watch<StructureProvider>();
    final prestationProvider = context.watch<PrestationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                const SizedBox(height: 14),
                _welcomeText(auth.prenom),
                const SizedBox(height: 16),
                _chatbotButton(context),
                const SizedBox(height: 18),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Nos Fonctionnalites',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _featuresSection(context),
                const SizedBox(height: 18),
                _structuresTitle(context),
                const SizedBox(height: 16),
                _structuresList(structureProvider),
                const SizedBox(height: 22),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Prestations AMU',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                _faqSection(prestationProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 88,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Image.asset(AppAssets.logo, width: 195, fit: BoxFit.contain),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _welcomeText(String? prenom) {
    final name = prenom == null || prenom.isEmpty ? '' : ' $prenom';

    return Center(
      child: Column(
        children: [
          Text(
            'Bienvenue$name,',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const Text(
            'Comment Pouvons-Nous Vous Aider ?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
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
          height: 82,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(55),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppAssets.chatbotSmall,
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Posez\nVotre Question\nAu Chatbot',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.05,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.keyboard_double_arrow_right,
                  color: AppColors.blue,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featuresSection(BuildContext context) {
    return SizedBox(
      height: 152,
      child: Stack(
        children: [
          Positioned(
            top: 28,
            left: 0,
            right: 0,
            child: Container(height: 108, color: AppColors.blue),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _featureCard(
                        image: AppAssets.chatbot,
                        title: 'Chatbot',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChatbotScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _featureCard(
                        image: AppAssets.stethoscope,
                        title: 'Verifier',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const VerificationScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _featureCard(
                        image: AppAssets.cross,
                        title: 'Structures',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StructuresScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _featureCard(
                        image: AppAssets.procedure,
                        title: 'Procedures',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProceduresScreen(),
                            ),
                          );
                        },
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
        height: 66,
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
            Image.asset(image, width: 34, height: 34, fit: BoxFit.contain),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.blue,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _structuresTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          const Text(
            'Structures proches',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StructuresScreen()),
              );
            },
            child: const Text(
              'Voir tout',
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _structuresList(StructureProvider provider) {
    if (provider.isLoading && provider.structures.isEmpty) {
      return const SizedBox(
        height: 255,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final structures = provider.structures.take(3).toList();

    if (structures.isEmpty) {
      return const SizedBox(
        height: 80,
        child: Center(
          child: Text(
            'Aucune structure disponible',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      );
    }

    return SizedBox(
      height: 255,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: structures.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          return _structureCard(structures[index]);
        },
      ),
    );
  }

  Widget _structureCard(StructureSante structure) {
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
              _structureImage(structure),
              height: 135,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            structure.nom,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          Text(
            '${structure.type} - ${structure.ville}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                structure.agrementAMU ? 'Agree AMU' : 'Non agree',
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _openStructureMap(structure),
                child: Container(
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _faqSection(PrestationProvider provider) {
    final prestations = provider.prestations.take(4).toList();

    if (provider.isLoading && prestations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (prestations.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Text(
          'Aucune prestation disponible',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      );
    }

    final first = prestations.take(2).toList();
    final second = prestations.skip(2).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        children: [
          Row(children: _faqRow(first)),
          const SizedBox(height: 10),
          if (second.isNotEmpty) Row(children: _faqRow(second)),
        ],
      ),
    );
  }

  List<Widget> _faqRow(List<Prestation> prestations) {
    final children = <Widget>[];
    for (var index = 0; index < prestations.length; index++) {
      if (index > 0) {
        children.add(const SizedBox(width: 60));
      }
      children.add(Expanded(child: _faqButton(prestations[index])));
    }
    return children;
  }

  Widget _faqButton(Prestation prestation) {
    return Row(
      children: [
        Expanded(
          child: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          VerificationResultScreen(prestation: prestation),
                    ),
                  );
                },
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      prestation.nomActe,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.keyboard_arrow_down, size: 28, color: Colors.black),
      ],
    );
  }

  String _structureImage(StructureSante structure) {
    final name = structure.nom.toLowerCase();

    if (name.contains('sylvanus')) return AppAssets.chuLome;
    if (name.contains('chu kara')) return AppAssets.chuKara;
    if (name.contains('biasa')) return AppAssets.cliniqueBiasa;
    if (name.contains('campus')) return AppAssets.pharmacieCampus;
    if (name.contains('kpalim')) return AppAssets.pharmacieKpalime;
    if (name.contains('sokod')) return AppAssets.hopitalRegionalSokode;
    return AppAssets.hospitalCard;
  }

  Future<void> _openStructureMap(StructureSante structure) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${structure.latitude},${structure.longitude}',
    );

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
