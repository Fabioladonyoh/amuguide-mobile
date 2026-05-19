import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../models/structure_sante.dart';
import 'package:url_launcher/url_launcher.dart';

class StructureCard extends StatelessWidget {
  final StructureSante structure;

  const StructureCard({
    super.key,
    required this.structure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x25000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              getImageByName(),
              width: double.infinity,
              height: 260,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 22),

          Text(
            structure.nom,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '${structure.type} • ${structure.ville}',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            structure.adresse,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              const Text(
                '1.2 km / 50 min',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              const Spacer(),

            GestureDetector(
  onTap: openMap,
  child: Container(
    height: 58,
    padding: const EdgeInsets.symmetric(horizontal: 28),
    color: AppColors.green,
    child: const Center(
      child: Text(
        'Voir carte',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.white,
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



Future<void> openMap() async {
  final url = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=${structure.latitude},${structure.longitude}',
  );

  await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  );
}

String getImageByName() {
  final name = structure.nom.toLowerCase();

  if (name.contains('sylvanus') || name.contains('chu sylvanus')) {
    return AppAssets.chuLome;
  }

  if (name.contains('chu kara')) {
    return AppAssets.chuKara;
  }

  if (name.contains('biasa')) {
    return AppAssets.cliniqueBiasa;
  }

  if (name.contains('évangélique') || name.contains('be') || name.contains('bè')) {
    return AppAssets.cliniqueBe;
  }

  if (name.contains('kpalimé')) {
    return AppAssets.pharmacieKpalime;
  }

  if (name.contains('campus')) {
    return AppAssets.pharmacieCampus;
  }

  if (name.contains('kara') && name.contains('médical')) {
    return AppAssets.centreMedicalKara;
  }

  if (name.contains('atakpamé')) {
    return AppAssets.centreSanteAtakpame;
  }

  if (name.contains('sokodé') && name.contains('hôpital')) {
    return AppAssets.hopitalRegionalSokode;
  }

  if (name.contains('sokodé') && name.contains('pharmacie')) {
  return AppAssets.pharmacieSokode;
}

  return AppAssets.hospitalCard;
}

}