class ContactRequest {
  final String nom;
  final String prenom;
  final String telephone;
  final String email;
  final String sujet;
  final String message;

  const ContactRequest({
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.email,
    required this.sujet,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'sujet': sujet,
      'message': message,
    };
  }
}
