import '../core/constants/app_config.dart';
import '../models/prestation.dart';
import 'api_service.dart';

class VerificationService {
  final ApiService _apiService = ApiService();

  Future<List<Prestation>> searchPrestation(String motCle) async {
    final data = await _apiService.get(
      '${AppConfig.verificationSearch}?motCle=$motCle',
    );

    return (data as List)
        .map((item) => Prestation.fromJson(item))
        .toList();
  }
}