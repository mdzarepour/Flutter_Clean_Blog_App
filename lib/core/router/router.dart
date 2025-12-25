import 'package:blog/core/common/user/cubit/user_cubit.dart';
import 'package:blog/core/common/widgets/loading_widget.dart';
import 'package:blog/core/router/router_names.dart';
import 'package:blog/core/utils/widget_helper.dart';
import 'package:blog/features/bog/domain/entities/blog_entity.dart';
import 'package:blog/features/bog/presentation/pages/publish_blog_page.dart';
import 'package:blog/features/bog/presentation/pages/home_blog_page.dart';
import 'package:blog/features/auth/presentation/pages/onboarding_page.dart';
import 'package:blog/features/auth/presentation/pages/signin_page.dart';
import 'package:blog/features/auth/presentation/pages/signup_page.dart';
import 'package:blog/features/bog/presentation/pages/read_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final WidgetHelper snackbarService;
  final UserCubit userCubit;

  const AppRouter({required this.userCubit, required this.snackbarService});

  GoRouter get router => GoRouter(
    navigatorKey: snackbarService.navigatorKey,
    routes: [
      // auth pages -->
      GoRoute(
        path: RouterNames.onboardingPage,
        builder: (context, state) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserExist) {
                return HomeBlogPage();
              }
              if (state is UserNotExist) {
                return OnboardingPage();
              }
              return Scaffold(body: LoadingWidget());
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
        path: RouterNames.blogPage,
        pageBuilder: (context, state) {
          return CupertinoPage(child: HomeBlogPage());
        },
      ),
      // blog pages -->
      GoRoute(
        path: RouterNames.blogPage,
        pageBuilder: (context, state) {
          return CupertinoPage(child: HomeBlogPage());
        },
      ),
      GoRoute(
        path: RouterNames.addBlogPage,
        pageBuilder: (context, state) {
          return CupertinoPage(child: PublishBlogPage());
        },
      ),
      GoRoute(
        path: RouterNames.readBlogPage,
        pageBuilder: (context, state) {
          final blog = state.extra as BlogEntity;
          return CupertinoPage(child: ReadBlogPage(blog: blog));
        },
      ),
    ],
  );
}
