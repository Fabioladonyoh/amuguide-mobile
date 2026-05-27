import 'package:flutter/material.dart';

import '../models/demande_response.dart';
import '../services/demande_service.dart';

class DemandeProvider extends ChangeNotifier {
  final DemandeService _service = DemandeService();

  bool isLoading = false;
  String? errorMessage;
  List<DemandeResponse> demandes = [];

  Future<void> loadDemandes(String? token) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      if (token == null || token.isEmpty) {
        throw Exception('Token manquant');
      }
      demandes = await _service.getDemandes(token);
      demandes.sort((a, b) {
        final left = a.dateDemande ?? DateTime.fromMillisecondsSinceEpoch(0);
        final right = b.dateDemande ?? DateTime.fromMillisecondsSinceEpoch(0);
        return right.compareTo(left);
      });
    } catch (e) {
      errorMessage = e.toString();
      demandes = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void clear() {
    demandes = [];
    errorMessage = null;
    notifyListeners();
  }

  void clearDemandesOnly() {
    demandes = [];
    notifyListeners();
  }
}
