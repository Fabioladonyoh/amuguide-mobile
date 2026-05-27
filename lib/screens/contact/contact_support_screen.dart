import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/assure_profile.dart';
import '../../models/contact_request.dart';
import '../../services/contact_service.dart';

class ContactSupportScreen extends StatefulWidget {
  final AssureProfile profile;

  const ContactSupportScreen({super.key, required this.profile});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final ContactService _service = ContactService();
  late final TextEditingController nomController;
  late final TextEditingController prenomController;
  late final TextEditingController telephoneController;
  late final TextEditingController emailController;
  final TextEditingController sujetController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nomController = TextEditingController(text: widget.profile.nom);
    prenomController = TextEditingController(text: widget.profile.prenom);
    telephoneController = TextEditingController(text: widget.profile.telephone);
    emailController = TextEditingController(text: widget.profile.email);
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    telephoneController.dispose();
    emailController.dispose();
    sujetController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (sujetController.text.trim().isEmpty ||
        messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sujet et message sont obligatoires.')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await _service.send(
        ContactRequest(
          nom: nomController.text.trim(),
          prenom: prenomController.text.trim(),
          telephone: telephoneController.text.trim(),
          email: emailController.text.trim(),
          sujet: sujetController.text.trim(),
          message: messageController.text.trim(),
        ),
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message envoye avec succes.')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Envoi impossible. Reessayez.')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Contacter le support'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
          child: Column(
            children: [
              _field('Nom', nomController),
              _field('Prenom', prenomController),
              _field('Telephone', telephoneController),
              _field('Email', emailController),
              _field('Sujet', sujetController),
              _field('Message', messageController, maxLines: 5),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: isLoading ? null : _send,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Envoyer',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
