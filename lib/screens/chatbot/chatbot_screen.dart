import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/chatbot_provider.dart';
import '../../widgets/chat_bubble.dart';
import '../../widgets/chat_input.dart';
import 'chat_message.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<ChatMessage> messages = [];

  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      messages.add(ChatMessage(text: text, isUser: true));
    });

    messageController.clear();

    final response = await context.read<ChatbotProvider>().sendMessage(text);

    if (!mounted) {
      return;
    }

    setState(() {
      messages.add(
        ChatMessage(
          text:
              response?.displayMessage ??
              'Erreur reseau. Reessayez dans un instant.',
          isUser: false,
        ),
      );
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Expanded(child: messages.isEmpty ? _emptyState() : _messagesList()),
            ChatInput(
              controller: messageController,
              onSend: sendMessage,
              onCamera: () => _showUnavailable('Camera'),
              onGallery: () => _showUnavailable('Galerie'),
              onFile: () => _showUnavailable('Document'),
              onVoice: () => _showUnavailable('Message vocal'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 110,
      color: const Color(0xFFF3F3F3),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: const Icon(Icons.arrow_back, size: 38, color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'Chatbot',
              style: TextStyle(fontSize: 28, color: Colors.black),
            ),
          ),
          const Spacer(),
          const SizedBox(width: 38),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Text(
        'Bonjour\nJe suis votre assistant AMU.\nComment puis-je vous aider ?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22, height: 1.45, color: Colors.black),
      ),
    );
  }

  Widget _messagesList() {
    final isLoading = context.watch<ChatbotProvider>().isLoading;
    final itemCount = messages.length + (isLoading ? 1 : 0);

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(30, 60, 30, 20),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= messages.length) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 28),
            child: Text(
              'AMU-Guide ecrit...',
              style: TextStyle(color: Colors.black54, fontSize: 20),
            ),
          );
        }

        return ChatBubble(message: messages[index]);
      },
    );
  }

  void _showUnavailable(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$feature bientot disponible. Utilisez le texte pour le moment.',
        ),
      ),
    );
  }
}
