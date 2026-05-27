import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_response.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  static const _tokenKey = 'auth_token';
  static const _roleKey = 'auth_role';
  static const _nomKey = 'auth_nom';
  static const _prenomKey = 'auth_prenom';
  static const _identifiantKey = 'auth_identifiant';

  final AuthService _service = AuthService();

  bool isLoading = false;
  bool isInitialized = false;
  String? errorMessage;
  String? token;
  String? role;
  String? nom;
  String? prenom;
  String? identifiant;

  bool get isAuthenticated => token != null && token!.isNotEmpty;

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(_tokenKey);
    role = prefs.getString(_roleKey);
    nom = prefs.getString(_nomKey);
    prenom = prefs.getString(_prenomKey);
    identifiant = prefs.getString(_identifiantKey);
    isInitialized = true;
    notifyListeners();
  }

  Future<bool> login({
    required String numeroAMU,
    required String motDePasse,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _service.loginAssure(
        numeroAMU: numeroAMU,
        motDePasse: motDePasse,
      );
      await _saveSession(response);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = _cleanError(e);
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_roleKey);
    await prefs.remove(_nomKey);
    await prefs.remove(_prenomKey);
    await prefs.remove(_identifiantKey);

    token = null;
    role = null;
    nom = null;
    prenom = null;
    identifiant = null;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> _saveSession(AuthResponse response) async {
    token = response.token;
    role = response.role;
    nom = response.nom;
    prenom = response.prenom;
    identifiant = response.identifiant;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, response.token);
    await prefs.setString(_roleKey, response.role);
    await prefs.setString(_nomKey, response.nom);
    await prefs.setString(_prenomKey, response.prenom);
    await prefs.setString(_identifiantKey, response.identifiant);
  }

  String _cleanError(Object error) {
    final text = error.toString();
    if (text.contains('400') || text.contains('401')) {
      return 'Numero AMU ou mot de passe incorrect.';
    }
    return 'Connexion impossible. Verifiez le backend et reessayez.';
  }
}
