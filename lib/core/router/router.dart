import 'dart:developer';
import 'package:blog/core/router/router_names.dart';
import 'package:blog/core/services/services.dart';
import 'package:blog/core/services/snackbar_service.dart';
import 'package:blog/core/widgets/exit_wrapper.dart';
import 'package:blog/features/auth/presentation/pages/onboarding_page.dart';
import 'package:blog/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final SnackbarService snackbarService;

  const AppRouter({required this.snackbarService});

  GoRouter get router => GoRouter(
    navigatorKey: snackbarService.navigatorKey,
    routes: [
      GoRoute(
        path: RouterNames.onboardingPage,
        pageBuilder: (context, state) {
          return CupertinoPage(child: ExitWrapper(child: OnboardingPage()));
        },
      ),
      GoRoute(
        path: RouterNames.signinPage,
        pageBuilder: (context, state) {
          return CupertinoPage(child: ExitWrapper(child: SigninPage()));
        },
      ),
    ],
  );
}
