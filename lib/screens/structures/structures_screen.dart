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
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<StructureProvider>().loadStructures();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StructureProvider>();

    final byType = selectedFilter == 'TOUS'
        ? provider.structures
        : provider.structures
              .where((structure) => structure.type == selectedFilter)
              .toList();
    final normalizedQuery = searchQuery.trim().toLowerCase();
    final filteredStructures = normalizedQuery.isEmpty
        ? byType
        : byType.where((structure) {
            return structure.nom.toLowerCase().contains(normalizedQuery) ||
                structure.type.toLowerCase().contains(normalizedQuery) ||
                structure.ville.toLowerCase().contains(normalizedQuery) ||
                structure.adresse.toLowerCase().contains(normalizedQuery) ||
                structure.specialites.toLowerCase().contains(normalizedQuery);
          }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 28),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SearchBarWidget(
                controller: searchController,
                onChanged: (value) => setState(() => searchQuery = value),
              ),
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
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.errorMessage != null) {
                    return Center(child: Text(provider.errorMessage!));
                  }

                  if (filteredStructures.isEmpty) {
                    return const Center(
                      child: Text('Aucune structure trouvée'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: filteredStructures.length,
                    itemBuilder: (context, index) {
                      final structure = filteredStructures[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 22),
                        child: StructureCard(structure: structure),
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
