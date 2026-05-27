import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../models/contact_request.dart';
import '../../services/contact_service.dart';
import 'login_screen.dart';
import 'widgets/auth_button.dart';
import 'widgets/auth_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ContactService _contactService = ContactService();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedSexe;
  DateTime? selectedDate;
  bool rememberMe = false;
  bool isLoading = false;
  bool isPasswordHidden = true;

  @override
  void dispose() {
    nomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final nom = nomController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (selectedSexe == null) {
      _showMessage('Choisissez Homme ou Femme.');
      return;
    }
    if (nom.isEmpty) {
      _showMessage('Le nom est obligatoire.');
      return;
    }
    if (selectedDate == null) {
      _showMessage('La date de naissance est obligatoire.');
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      _showMessage('Entrez un email valide.');
      return;
    }
    if (password.length < 6) {
      _showMessage('Le mot de passe doit contenir au moins 6 caracteres.');
      return;
    }

    setState(() => isLoading = true);

    try {
      await _contactService.send(
        ContactRequest(
          nom: nom,
          prenom: selectedSexe!,
          telephone: 'Non renseigne',
          email: email,
          sujet: 'Demande d inscription AMU',
          message:
              'Sexe: $selectedSexe\nDate de naissance: ${_formatDate(selectedDate!)}\nMot de passe souhaite: $password',
        ),
      );

      if (!mounted) {
        return;
      }

      _showMessage('Demande envoyee. Le support AMU vous recontactera.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      _showMessage('Envoi impossible. Verifiez le backend puis reessayez.');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(1998, 4, 16),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year, now.month, now.day),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logoHeader(),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Row(
                  children: [
                    _selectBox('Homme'),
                    const SizedBox(width: 30),
                    _selectBox('Femme'),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              _label('Nom'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: AuthTextField(
                  controller: nomController,
                  hintText: 'entrer votre nom',
                  icon: Icons.person,
                ),
              ),
              const SizedBox(height: 26),
              _label('Date de naissance'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: GestureDetector(
                  onTap: _pickDate,
                  child: Row(
                    children: [
                      _dateBox(_dayText),
                      const SizedBox(width: 22),
                      _dateBox(_monthText),
                      const SizedBox(width: 22),
                      _dateBox(_yearText),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 26),
              _label('Email'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: AuthTextField(
                  controller: emailController,
                  hintText: 'entrer votre E-mail',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 26),
              _label('Mot de passe'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: AuthTextField(
                  controller: passwordController,
                  hintText: '****************',
                  icon: Icons.lock,
                  obscureText: isPasswordHidden,
                  onToggleVisibility: () {
                    setState(() => isPasswordHidden = !isPasswordHidden);
                  },
                ),
              ),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: GestureDetector(
                  onTap: () => setState(() => rememberMe = !rememberMe),
                  child: Row(
                    children: [
                      _checkBox(rememberMe),
                      const SizedBox(width: 12),
                      const Text('Se souvenir', style: TextStyle(fontSize: 17)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AuthButton(label: 'S’inscrire', onTap: _submit),
              ),
              const SizedBox(height: 30),
              _socialSeparator(),
              const SizedBox(height: 22),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFF1877F2),
                    child: Text(
                      'f',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 34),
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Text(
                      'G',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Vous avez deja un compte? ',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        TextSpan(
                          text: 'Connectez - vous',
                          style: TextStyle(
                            color: Color(0xFF004A99),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
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

  Widget _logoHeader() {
    return Container(
      height: 160,
      width: double.infinity,
      color: const Color(0xFF0067B1),
      child: Center(
        child: Image.asset(AppAssets.logo, width: 330, fit: BoxFit.contain),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _selectBox(String value) {
    return GestureDetector(
      onTap: () => setState(() => selectedSexe = value),
      child: Row(
        children: [
          _checkBox(selectedSexe == value),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _checkBox(bool checked) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: checked ? const Color(0xFF004A99) : Colors.transparent,
        border: Border.all(color: Colors.black87, width: 1.5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: checked
          ? const Icon(Icons.check, color: Colors.white, size: 18)
          : null,
    );
  }

  Widget _dateBox(String value) {
    return Expanded(
      child: Container(
        height: 74,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.4),
          borderRadius: BorderRadius.circular(38),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 24, color: Colors.grey),
            ),
            const SizedBox(width: 18),
            const Icon(Icons.keyboard_arrow_down, size: 32, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _socialSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.black, thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Ou Continuer avec', style: TextStyle(fontSize: 20)),
          ),
          Expanded(child: Divider(color: Colors.black, thickness: 1)),
        ],
      ),
    );
  }

  String get _dayText => selectedDate == null
      ? '16'
      : selectedDate!.day.toString().padLeft(2, '0');

  String get _monthText => selectedDate == null
      ? '04'
      : selectedDate!.month.toString().padLeft(2, '0');

  String get _yearText =>
      selectedDate == null ? '1998' : selectedDate!.year.toString();

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
