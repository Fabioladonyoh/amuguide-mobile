/*import 'package:flutter/material.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Center(
        child: Text('Chatbot'),
      ),

    );
  }
}*/



import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
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

  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      messages.add(
        ChatMessage(text: text, isUser: true),
      );

      messages.add(
        ChatMessage(
          text:
          'Oui, le scanner est pris en charge par l’AMU.\nLe taux de couverture dépend de votre type d’assurance et des conditions médicales.\nNous vous recommandons de consulter un centre de santé agréé pour plus de détails.',
          isUser: false,
        ),
      );
    });

    messageController.clear();
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
            Expanded(
              child: messages.isEmpty ? _emptyState() : _messagesList(),
            ),
            ChatInput(
              controller: messageController,
              onSend: sendMessage,
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
            onTap: () {
              // Retour vers l'accueil via bottom navigation plus tard
            },
            child: const Icon(
              Icons.arrow_back,
              size: 38,
              color: Colors.black,
            ),
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
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
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
        'Bonjour 👋\nJe suis votre assistant AMU.\nComment puis-je vous aider ?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          height: 1.45,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _messagesList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(30, 60, 30, 20),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatBubble(message: messages[index]);
      },
    );
  }
}