class Prestation {
  final int idPrestation;
  final String codeActe;
  final String nomActe;
  final String categorie;
  final String description;
  final double tauxCouverture;
  final bool prisEnCharge;
  final String conditionsPriseEnCharge;
  final String documentsRequis;

  Prestation({
    required this.idPrestation,
    required this.codeActe,
    required this.nomActe,
    required this.categorie,
    required this.description,
    required this.tauxCouverture,
    required this.prisEnCharge,
    required this.conditionsPriseEnCharge,
    required this.documentsRequis,
  });

  factory Prestation.fromJson(Map<String, dynamic> json) {
    return Prestation(
      idPrestation: json['idPrestation'] ?? 0,
      codeActe: json['codeActe'] ?? '',
      nomActe: json['nomActe'] ?? '',
      categorie: json['categorie'] ?? '',
      description: json['description'] ?? '',
      tauxCouverture: (json['tauxCouverture'] ?? 0).toDouble(),
      prisEnCharge: json['prisEnCharge'] ?? false,
      conditionsPriseEnCharge: json['conditionsPriseEnCharge'] ?? '',
      documentsRequis: json['documentsRequis'] ?? '',
    );
  }
}