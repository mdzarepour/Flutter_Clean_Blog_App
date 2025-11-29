import 'package:blog/core/common/user/cubit/user_cubit.dart';
import 'package:blog/core/router/router_names.dart';
import 'package:blog/core/services/widget_service.dart';
import 'package:blog/features/auth/presentation/pages/home_page.dart';
import 'package:blog/features/auth/presentation/pages/onboarding_page.dart';
import 'package:blog/features/auth/presentation/pages/signin_page.dart';
import 'package:blog/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final WidgetServices snackbarService;
  final UserCubit userCubit;

  const AppRouter({required this.userCubit, required this.snackbarService});

  GoRouter get router => GoRouter(
    navigatorKey: snackbarService.navigatorKey,
    routes: [
      GoRoute(
        path: RouterNames.onboardingPage,
        builder: (context, state) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserExist) {
                return HomePage();
              }
              if (state is UserNotExist) {
                return OnboardingPage();
              }
              return SizedBox.shrink();
            },
          );
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
      GoRoute(
        path: RouterNames.homePage,
        pageBuilder: (context, state) {
          return CupertinoPage(child: HomePage());
        },
      ),
    ],
  );
}
