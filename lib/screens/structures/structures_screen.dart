import 'package:flutter/material.dart';

import 'widgets/filter_button.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/structure_card.dart';

class StructuresScreen extends StatelessWidget {
  const StructuresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 28),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SearchBarWidget(),
            ),

            SizedBox(height: 24),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterButton(label: 'Tous', isActive: true),
                  FilterButton(label: 'Hôpitaux', isActive: false),
                  FilterButton(label: 'Pharmacies', isActive: false),
                ],
              ),
            ),

            SizedBox(height: 28),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  children: [
                    StructureCard(),
                    StructureCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}