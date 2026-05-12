import 'package:flutter/material.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_colors.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          const Icon(Icons.camera_alt_outlined, size: 32),
          const SizedBox(width: 18),

          const Icon(Icons.image_outlined, size: 32),
          const SizedBox(width: 18),

          const Icon(Icons.folder_outlined, size: 32),
          const SizedBox(width: 22),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Text',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const Icon(Icons.mic_none, size: 36, color: Colors.black),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.stop,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}