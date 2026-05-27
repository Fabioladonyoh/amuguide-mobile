import 'package:flutter/material.dart';

import '../models/chatbot_response.dart';
import '../services/chatbot_service.dart';

class ChatbotProvider extends ChangeNotifier {
  final ChatbotService _service = ChatbotService();

  bool isLoading = false;
  String? errorMessage;

  Future<ChatbotResponse?> sendMessage(String message) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _service.sendMessage(message);
      isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      errorMessage = 'Erreur reseau. Reessayez dans un instant.';
      isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
