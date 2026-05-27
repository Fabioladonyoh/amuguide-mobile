class DemandeResponse {
  final int? idDemande;
  final String typeDemande;
  final DateTime? dateDemande;
  final String statut;
  final String description;
  final String? resultat;

  const DemandeResponse({
    this.idDemande,
    required this.typeDemande,
    required this.dateDemande,
    required this.statut,
    required this.description,
    this.resultat,
  });

  factory DemandeResponse.fromJson(Map<String, dynamic> json) {
    final rawDate = json['dateDemande']?.toString();

    return DemandeResponse(
      idDemande: json['idDemande'] is int ? json['idDemande'] as int : null,
      typeDemande: json['typeDemande']?.toString() ?? '',
      dateDemande: rawDate == null ? null : DateTime.tryParse(rawDate),
      statut: json['statut']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      resultat: json['resultat']?.toString(),
    );
  }

  String get title {
    if (description.trim().isNotEmpty) {
      return description;
    }
    return typeDemande.replaceAll('_', ' ');
  }

  String get relativeTime {
    final date = dateDemande;
    if (date == null) {
      return '';
    }

    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) {
      return 'Maintenant';
    }
    if (diff.inMinutes < 60) {
      return 'Il y a ${diff.inMinutes} min';
    }
    if (diff.inHours < 24) {
      return 'Il y a ${diff.inHours} h';
    }
    if (diff.inDays == 1) {
      return 'Hier';
    }
    return 'Il y a ${diff.inDays} jours';
  }
}
