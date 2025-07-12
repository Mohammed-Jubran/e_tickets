import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String kSplashScreen = '/';
  static const String kLoginScreen = '/LoginScreen';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashScreen,
        builder: (context, state) => const SizedBox(),
      ),
      GoRoute(
        path: kLoginScreen,
        builder: (context, state) => const SizedBox(),
      ),
    ],
  );
}
