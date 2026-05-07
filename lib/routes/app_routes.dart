import 'package:flutter/material.dart';

import '../screens/main_navigation_screen.dart';

class AppRoutes {

  static const String mainNavigation = '/';

  static Map<String, WidgetBuilder> routes = {

    mainNavigation: (context) => const MainNavigationScreen(),

  };
}