import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/chatbot_provider.dart';
import 'providers/demande_provider.dart';
import 'providers/prestation_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/verification_provider.dart';
import 'providers/structure_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..loadSession()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => DemandeProvider()),
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
        ChangeNotifierProvider(create: (_) => PrestationProvider()),
        ChangeNotifierProvider(create: (_) => VerificationProvider()),
        ChangeNotifierProvider(create: (_) => StructureProvider()),
      ],
      child: const AmuGuideApp(),
    ),
  );
}
