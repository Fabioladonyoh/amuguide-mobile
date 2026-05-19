import 'package:flutter/material.dart';

import '../models/structure_sante.dart';
import '../services/structure_service.dart';

class StructureProvider
    extends ChangeNotifier {

  final StructureService _service =
      StructureService();

  bool isLoading = false;

  List<StructureSante> structures = [];

  String? errorMessage;

  Future<void> loadStructures() async {

    isLoading = true;

    notifyListeners();

    try {

      structures =
          await _service.getStructures();

    } catch (e) {

      errorMessage = e.toString();
    }

    isLoading = false;

    notifyListeners();
  }
}