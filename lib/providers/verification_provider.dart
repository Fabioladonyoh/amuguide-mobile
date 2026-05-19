import 'package:flutter/material.dart';

import '../models/prestation.dart';
import '../services/verification_service.dart';

class VerificationProvider extends ChangeNotifier {
  final VerificationService _service = VerificationService();

  bool isLoading = false;
  String? errorMessage;
  List<Prestation> prestations = [];

  Future<void> search(String motCle) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      prestations = await _service.searchPrestation(motCle);
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}