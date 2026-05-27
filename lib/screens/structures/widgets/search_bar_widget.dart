import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 42, color: Colors.black),
          const SizedBox(width: 18),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Rechercher un hopital ou une pharmacie...',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
