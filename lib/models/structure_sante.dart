class StructureSante {

  final int idStructure;
  final String nom;
  final String type;
  final String adresse;
  final String ville;
  final String telephone;
  final double latitude;
  final double longitude;
  final bool agrementAMU;
  final String specialites;
  final String horaires;

  StructureSante({
    required this.idStructure,
    required this.nom,
    required this.type,
    required this.adresse,
    required this.ville,
    required this.telephone,
    required this.latitude,
    required this.longitude,
    required this.agrementAMU,
    required this.specialites,
    required this.horaires,
  });

  factory StructureSante.fromJson(
    Map<String, dynamic> json,
  ) {

    return StructureSante(
      idStructure: json['idStructure'] ?? 0,
      nom: json['nom'] ?? '',
      type: json['type'] ?? '',
      adresse: json['adresse'] ?? '',
      ville: json['ville'] ?? '',
      telephone: json['telephone'] ?? '',
      latitude:
          (json['latitude'] ?? 0).toDouble(),
      longitude:
          (json['longitude'] ?? 0).toDouble(),
      agrementAMU:
          json['agrementAMU'] ?? false,
      specialites:
          json['specialites'] ?? '',
      horaires:
          json['horaires'] ?? '',
    );
  }
}