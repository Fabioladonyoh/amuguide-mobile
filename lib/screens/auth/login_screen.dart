import 'package:flutter/material.dart';

import '../main_navigation_screen.dart';
import '../../core/constants/app_assets.dart';
import 'register_screen.dart';
import 'widgets/auth_button.dart';
import 'widgets/auth_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              const SizedBox(height: 165),

              _label('Email'),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 34),
                child: AuthTextField(
                  hintText: 'entrer votre E-mail',
                  icon: Icons.email,
                ),
              ),

              const SizedBox(height: 30),

              _label('Mot de passe'),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 34),
                child: AuthTextField(
                  hintText: '****************',
                  icon: Icons.lock,
                  obscureText: true,
                ),
              ),

              const SizedBox(height: 14),

              const Padding(
                padding: EdgeInsets.only(right: 42),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 82),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: AuthButton(
                  label: 'Connexion',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainNavigationScreen(),
                      ),
                    );
                  },
                ),
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
                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Vous n’avez pas de compte? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
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
        child: Image.asset(
          AppAssets.logo,
          width: 330,
          fit: BoxFit.contain,
        ),
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
            child: Text(
              'Ou Continuer avec',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(child: Divider(color: Colors.black, thickness: 1)),
        ],
      ),
    );
  }
}