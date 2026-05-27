import '../core/constants/app_config.dart';
import '../models/contact_request.dart';
import 'api_service.dart';

class ContactService {
  final ApiService _apiService = ApiService();

  Future<void> send(ContactRequest request) async {
    await _apiService.post(AppConfig.contact, request.toJson());
  }
}
