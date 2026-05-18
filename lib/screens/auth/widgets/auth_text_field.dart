import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const AuthTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.4),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF4F7B), size: 34),
          const SizedBox(width: 22),
          Expanded(
            child: TextField(
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
              ),
              style: const TextStyle(fontSize: 22),
            ),
          ),
          if (obscureText)
            const Icon(
              Icons.visibility_off,
              size: 34,
              color: Colors.black87,
            ),
        ],
      ),
    );
  }
}