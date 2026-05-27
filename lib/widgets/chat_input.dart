import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onCamera;
  final VoidCallback? onGallery;
  final VoidCallback? onFile;
  final VoidCallback? onVoice;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    this.onCamera,
    this.onGallery,
    this.onFile,
    this.onVoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          _IconAction(icon: Icons.camera_alt_outlined, onTap: onCamera),
          const SizedBox(width: 18),
          _IconAction(icon: Icons.image_outlined, onTap: onGallery),
          const SizedBox(width: 18),
          _IconAction(icon: Icons.folder_outlined, onTap: onFile),
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
          _IconAction(icon: Icons.mic_none, size: 36, onTap: onVoice),
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
              child: const Icon(Icons.stop, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback? onTap;

  const _IconAction({required this.icon, this.size = 32, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: size, color: Colors.black),
    );
  }
}
