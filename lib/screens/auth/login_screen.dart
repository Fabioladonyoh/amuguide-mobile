import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_navigation_screen.dart';
import '../../core/constants/app_assets.dart';
import '../../providers/auth_provider.dart';
import 'register_screen.dart';
import 'widgets/auth_button.dart';
import 'widgets/auth_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    numeroController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      numeroAMU: numeroController.text.trim(),
      motDePasse: passwordController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    } else if (auth.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.errorMessage!),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logoHeader(),
              const SizedBox(height: 165),

              _label('Numero AMU'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: AuthTextField(
                  controller: numeroController,
                  hintText: 'AMU001',
                  icon: Icons.badge_outlined,
                  keyboardType: TextInputType.text,
                ),
              ),

              const SizedBox(height: 30),

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

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.only(right: 42),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _showForgotPasswordHelp,
                    child: const Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 82),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: auth.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AuthButton(label: 'Connexion', onTap: _login),
              ),

              const SizedBox(height: 165),

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
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Vous n’avez pas de compte? ',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        TextSpan(
                          text: 'Inscrivez - vous',
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

  void _showForgotPasswordHelp() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mot de passe oublié'),
          content: const Text(
            'Pour les comptes de test, le mot de passe correspond souvent a la date de naissance au format JJMMAAAA.\n\nExemple : AMU001 / 14052000.\n\nSinon, contactez le support AMU pour reinitialiser votre acces.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
