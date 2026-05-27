import '../core/constants/app_config.dart';
import '../models/assure_profile.dart';
import 'api_service.dart';

class ProfileService {
  final ApiService _apiService = ApiService();

  Future<AssureProfile> getProfile(String token) async {
    final data = await _apiService.get(AppConfig.profile, token: token);

    return AssureProfile.fromJson(data as Map<String, dynamic>);
  }
}
