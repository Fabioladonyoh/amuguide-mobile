import 'package:amuguide_mobile/app.dart';
import 'package:amuguide_mobile/providers/auth_provider.dart';
import 'package:amuguide_mobile/providers/chatbot_provider.dart';
import 'package:amuguide_mobile/providers/demande_provider.dart';
import 'package:amuguide_mobile/providers/prestation_provider.dart';
import 'package:amuguide_mobile/providers/profile_provider.dart';
import 'package:amuguide_mobile/providers/structure_provider.dart';
import 'package:amuguide_mobile/providers/verification_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('AMU Guide app builds', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
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

    expect(find.byType(AmuGuideApp), findsOneWidget);
  });
}
