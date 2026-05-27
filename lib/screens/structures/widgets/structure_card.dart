import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../models/structure_sante.dart';

class StructureCard extends StatelessWidget {
  final StructureSante structure;

  const StructureCard({super.key, required this.structure});

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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${structure.type} - ${structure.ville}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            structure.adresse,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
          const SizedBox(height: 18),
          const Text(
            '1.2 km / 50 min',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: openMap,
            child: Container(
              height: 46,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Voir carte',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openMap() async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${structure.latitude},${structure.longitude}',
    );

    await launchUrl(url, mode: LaunchMode.externalApplication);
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
    if (name.contains('evangelique') ||
        name.contains('évangélique') ||
        name.contains('be') ||
        name.contains('bè')) {
      return AppAssets.cliniqueBe;
    }
    if (name.contains('kpalim')) {
      return AppAssets.pharmacieKpalime;
    }
    if (name.contains('campus')) {
      return AppAssets.pharmacieCampus;
    }
    if (name.contains('kara') && name.contains('medical')) {
      return AppAssets.centreMedicalKara;
    }
    if (name.contains('atakpam')) {
      return AppAssets.centreSanteAtakpame;
    }
    if (name.contains('sokod') && name.contains('hopital')) {
      return AppAssets.hopitalRegionalSokode;
    }
    if (name.contains('sokod') && name.contains('pharmacie')) {
      return AppAssets.pharmacieSokode;
    }

    return AppAssets.hospitalCard;
  }
}
