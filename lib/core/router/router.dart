import 'package:blog/core/router/router_names.dart';
import 'package:blog/core/services/snackbar_service.dart';
import 'package:blog/features/auth/presentation/pages/home_page.dart';
import 'package:blog/features/auth/presentation/pages/onboarding_page.dart';
import 'package:blog/features/auth/presentation/pages/signin_page.dart';
import 'package:blog/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  final SnackbarService snackbarService;
  final SupabaseClient supabaseClient;
  const AppRouter({
    required this.snackbarService,
    required this.supabaseClient,
  });

  GoRouter get router => GoRouter(
    navigatorKey: snackbarService.navigatorKey,
    routes: [
      GoRoute(
        path: RouterNames.onboardingPage,
        pageBuilder: (context, state) {
          Session? session = supabaseClient.auth.currentSession;
          if (session == null) {
            return CupertinoPage(child: OnboardingPage());
          } else {
            return CupertinoPage(child: HomePage());
          }
        },
      ),
      GoRoute(
        path: RouterNames.signinPage,
        pageBuilder: (context, state) {
          return CupertinoPage(child: SigninPage());
        },
      ),
      GoRoute(
        path: RouterNames.signupPage,
        pageBuilder: (context, state) {
          return CupertinoPage(child: SignupPage());
        },
      ),
      GoRoute(
        path: RouterNames.homePage,
        pageBuilder: (context, state) {
          return CupertinoPage(child: HomePage());
        },
      ),
    ],
  );
}
