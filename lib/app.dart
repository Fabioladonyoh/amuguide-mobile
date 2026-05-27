import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import 'core/theme/app_theme.dart';

import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_navigation_screen.dart';

class AmuGuideApp extends StatelessWidget {
  const AmuGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMU-Guide',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const _AppScrollBehavior(),
          child: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(0.86)),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (!auth.isInitialized) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return auth.isAuthenticated
              ? const MainNavigationScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}

class _AppScrollBehavior extends MaterialScrollBehavior {
  const _AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return AlwaysScrollableScrollPhysics(
      parent: super.getScrollPhysics(context),
    );
  }
}
