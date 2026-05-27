import '../core/constants/app_config.dart';
import '../models/demande_response.dart';
import 'api_service.dart';

class DemandeService {
  final ApiService _apiService = ApiService();

  Future<List<DemandeResponse>> getDemandes(String token) async {
    final data = await _apiService.get(AppConfig.demandes, token: token);

    return (data as List)
        .map((item) => DemandeResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
