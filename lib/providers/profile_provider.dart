import 'package:flutter/material.dart';

import '../models/assure_profile.dart';
import '../services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _service = ProfileService();

  bool isLoading = false;
  String? errorMessage;
  AssureProfile? profile;

  Future<void> loadProfile({
    required String? token,
    required String? nom,
    required String? prenom,
    required String? identifiant,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      if (token == null || token.isEmpty) {
        throw Exception('Token manquant');
      }
      profile = await _service.getProfile(token);
    } catch (e) {
      errorMessage = e.toString();
      profile = AssureProfile.fallback(
        nom: nom ?? '',
        prenom: prenom ?? '',
        identifiant: identifiant ?? '',
      );
    }

    isLoading = false;
    notifyListeners();
  }

  void clear() {
    profile = null;
    errorMessage = null;
    notifyListeners();
  }
}
