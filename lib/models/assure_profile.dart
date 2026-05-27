class AssureProfile {
  final int? idAssure;
  final String nom;
  final String prenom;
  final String numeroAMU;
  final String dateNaissance;
  final String telephone;
  final String email;
  final String adresse;
  final String statut;

  const AssureProfile({
    this.idAssure,
    required this.nom,
    required this.prenom,
    required this.numeroAMU,
    required this.dateNaissance,
    required this.telephone,
    required this.email,
    required this.adresse,
    required this.statut,
  });

  factory AssureProfile.fromJson(Map<String, dynamic> json) {
    return AssureProfile(
      idAssure: json['idAssure'] is int ? json['idAssure'] as int : null,
      nom: json['nom']?.toString() ?? '',
      prenom: json['prenom']?.toString() ?? '',
      numeroAMU: json['numeroAMU']?.toString() ?? '',
      dateNaissance: json['dateNaissance']?.toString() ?? '',
      telephone: json['telephone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      adresse: json['adresse']?.toString() ?? '',
      statut: json['statut']?.toString() ?? '',
    );
  }

  factory AssureProfile.fallback({
    required String nom,
    required String prenom,
    required String identifiant,
  }) {
    return AssureProfile(
      nom: nom,
      prenom: prenom,
      numeroAMU: identifiant.replaceFirst('ASSURE:', ''),
      dateNaissance: '',
      telephone: '',
      email: '',
      adresse: '',
      statut: 'ACTIF',
    );
  }

  String get fullName {
    final value = '$prenom $nom'.trim();
    return value.isEmpty ? 'Assure AMU' : value;
  }
}
