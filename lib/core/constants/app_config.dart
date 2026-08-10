import 'package:flutter/foundation.dart';

class AppConfig {
  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8082/api';
    }

    return 'http://localhost:8082/api';
  }

  static const String verificationSearch = '/verifications/search';
  static const String structures = '/structures';
  static const String structuresAgrees = '/structures/agrees';
  static const String prestations = '/prestations';
  static const String chatbot = '/chatbot';
  static const String contact = '/contact';

  static const String assureLogin = '/auth/assure/login';
  static const String profile = '/me/profil';
  static const String demandes = '/me/demandes';
}
