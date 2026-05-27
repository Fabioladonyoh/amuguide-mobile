import '../core/constants/app_config.dart';
import '../models/chatbot_response.dart';
import 'api_service.dart';

class ChatbotService {
  final ApiService _apiService = ApiService();

  Future<ChatbotResponse> sendMessage(String message) async {
    final data = await _apiService.post(AppConfig.chatbot, {
      'message': message,
    });

    return ChatbotResponse.fromJson(data as Map<String, dynamic>);
  }
}
