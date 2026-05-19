import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/structure_provider.dart';
import 'widgets/filter_button.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/structure_card.dart';

class StructuresScreen extends StatefulWidget {
  const StructuresScreen({super.key});

  @override
  State<StructuresScreen> createState() => _StructuresScreenState();
}

class _StructuresScreenState extends State<StructuresScreen> {
  String selectedFilter = 'TOUS';

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<StructureProvider>().loadStructures();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StructureProvider>();

    final filteredStructures = selectedFilter == 'TOUS'
        ? provider.structures
        : provider.structures
            .where((structure) => structure.type == selectedFilter)
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 28),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SearchBarWidget(),
            ),

            const SizedBox(height: 24),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  FilterButton(
                    label: 'Tous',
                    isActive: selectedFilter == 'TOUS',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'TOUS';
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  FilterButton(
                    label: 'Hôpitaux',
                    isActive: selectedFilter == 'HOPITAL',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'HOPITAL';
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  FilterButton(
                    label: 'Pharmacies',
                    isActive: selectedFilter == 'PHARMACIE',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'PHARMACIE';
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  FilterButton(
                    label: 'Cliniques',
                    isActive: selectedFilter == 'CLINIQUE',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'CLINIQUE';
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  FilterButton(
                    label: 'Centres',
                    isActive: selectedFilter == 'CENTRE_DE_SANTE',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'CENTRE_DE_SANTE';
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Expanded(
              child: Builder(
                builder: (_) {
                  if (provider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (provider.errorMessage != null) {
                    return Center(
                      child: Text(provider.errorMessage!),
                    );
                  }

                  if (filteredStructures.isEmpty) {
                    return const Center(
                      child: Text('Aucune structure trouvée'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    itemCount: filteredStructures.length,
                    itemBuilder: (context, index) {
                      final structure = filteredStructures[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 22),
                        child: StructureCard(
                          structure: structure,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}