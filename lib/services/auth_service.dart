import '../core/constants/app_config.dart';
import '../models/auth_response.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<AuthResponse> loginAssure({
    required String numeroAMU,
    required String motDePasse,
  }) async {
    final data = await _apiService.post(AppConfig.assureLogin, {
      'numeroAMU': numeroAMU,
      'motDePasse': motDePasse,
    });

    return AuthResponse.fromJson(data as Map<String, dynamic>);
  }
}
