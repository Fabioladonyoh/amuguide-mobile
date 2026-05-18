import 'package:flutter/material.dart';

import 'history_item.dart';

class HistoryCard extends StatelessWidget {
  final List<HistoryItem> items;

  const HistoryCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(26, 36, 26, 22),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black, width: 1.4),
          bottom: BorderSide(color: Colors.black, width: 1.4),
        ),
      ),
      child: Column(
        children: items,
      ),
    );
  }
}
