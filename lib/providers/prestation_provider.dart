import 'package:flutter/material.dart';

import '../models/prestation.dart';
import '../services/prestation_service.dart';

class PrestationProvider extends ChangeNotifier {
  final PrestationService _service = PrestationService();

  bool isLoading = false;
  String? errorMessage;
  List<Prestation> prestations = [];

  Future<void> loadPrestations() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      prestations = await _service.getPrestations();
    } catch (e) {
      errorMessage = e.toString();
      prestations = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
