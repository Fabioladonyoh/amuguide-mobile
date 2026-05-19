import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/verification_provider.dart';
import 'providers/structure_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VerificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StructureProvider(),
        ),
      ],
      child: const AmuGuideApp(),
    ),
  );
}