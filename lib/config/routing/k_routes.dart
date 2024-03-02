import 'package:easacc_task/screens/login/view/login_screen.dart';
import 'package:easacc_task/screens/settings/view/settings_screen.dart';
import 'package:flutter/material.dart';

import '../../screens/splash/view/splash_screen.dart';
import '../../screens/webview/webview_screen.dart';
import 'route_transitions.dart';

class KAppRoutes {
  static const String splash = '/';
  static const String loginScreen = '/loginScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String webView = '/webView';

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return createRoute(const SplashScreen(), settings: routeSettings);
      case loginScreen:
        return createRoute(const LoginScreen(), settings: routeSettings);
      case settingsScreen:
        return createRoute(const SettingsScreen(), settings: routeSettings);
      case webView:
        return createRoute(WebviewScreen(), settings: routeSettings);

    }
    return null;
  }
}
