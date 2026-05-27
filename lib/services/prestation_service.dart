import '../core/constants/app_config.dart';
import '../models/prestation.dart';
import 'api_service.dart';

class PrestationService {
  final ApiService _apiService = ApiService();

  Future<List<Prestation>> getPrestations() async {
    final data = await _apiService.get(AppConfig.prestations);

    return (data as List)
        .map((item) => Prestation.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Prestation>> searchPrestations(String nom) async {
    final data = await _apiService.get(
      '${AppConfig.prestations}/search?nom=$nom',
    );

    return (data as List)
        .map((item) => Prestation.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
