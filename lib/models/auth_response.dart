class AuthResponse {
  final String token;
  final String type;
  final String role;
  final String identifiant;
  final String nom;
  final String prenom;

  const AuthResponse({
    required this.token,
    required this.type,
    required this.role,
    required this.identifiant,
    required this.nom,
    required this.prenom,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token']?.toString() ?? '',
      type: json['type']?.toString() ?? 'Bearer',
      role: json['role']?.toString() ?? '',
      identifiant: json['identifiant']?.toString() ?? '',
      nom: json['nom']?.toString() ?? '',
      prenom: json['prenom']?.toString() ?? '',
    );
  }
}
