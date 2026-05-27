class ChatbotResponse {
  final String statut;
  final String message;
  final String codeActe;
  final String nomActe;
  final bool? prisEnCharge;
  final double? tauxCouverture;
  final String conditionsPriseEnCharge;
  final String documentsRequis;
  final String suggestions;

  const ChatbotResponse({
    required this.statut,
    required this.message,
    required this.codeActe,
    required this.nomActe,
    required this.prisEnCharge,
    required this.tauxCouverture,
    required this.conditionsPriseEnCharge,
    required this.documentsRequis,
    required this.suggestions,
  });

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) {
    final taux = json['tauxCouverture'];

    return ChatbotResponse(
      statut: json['statut']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      codeActe: json['codeActe']?.toString() ?? '',
      nomActe: json['nomActe']?.toString() ?? '',
      prisEnCharge: json['prisEnCharge'] is bool
          ? json['prisEnCharge'] as bool
          : null,
      tauxCouverture: taux is num ? taux.toDouble() : null,
      conditionsPriseEnCharge:
          json['conditionsPriseEnCharge']?.toString() ?? '',
      documentsRequis: json['documentsRequis']?.toString() ?? '',
      suggestions: json['suggestions']?.toString() ?? '',
    );
  }

  String get displayMessage {
    final parts = <String>[
      if (message.isNotEmpty) message,
      if (nomActe.isNotEmpty) 'Acte: $nomActe',
      if (codeActe.isNotEmpty) 'Code: $codeActe',
      if (prisEnCharge != null)
        prisEnCharge! ? 'Pris en charge: Oui' : 'Pris en charge: Non',
      if (tauxCouverture != null) 'Taux: ${tauxCouverture!.round()}%',
      if (conditionsPriseEnCharge.isNotEmpty)
        'Conditions: $conditionsPriseEnCharge',
      if (documentsRequis.isNotEmpty) 'Documents: $documentsRequis',
      if (suggestions.isNotEmpty) suggestions,
    ];

    return parts.isEmpty ? 'Reponse indisponible.' : parts.join('\n');
  }
}
