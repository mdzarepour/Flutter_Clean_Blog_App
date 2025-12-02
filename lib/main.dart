import 'package:blog/core/common/theme/app_theme.dart';
import 'package:blog/core/common/user/cubit/user_cubit.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/bog/presentation/bloc/blog_bloc.dart';
import 'package:blog/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return locator.get<UserCubit>()..getCurrentUser();
          },
        ),
        BlocProvider(
          create: (context) {
            return locator.get<AuthBloc>();
          },
        ),
        BlocProvider(
          create: (context) {
            return locator.get<BlogBloc>();
          },
        ),
      ],
      child: MaterialApp.router(
        routerConfig: locator.get<GoRouter>(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
      ),
    );
  }
}

//TODO turn on keep alive in onboarding page
//TODO use go router for navigations
// TODO add regex to fields
// TODO add exit wrapper
// TODO make pop up menu reusable
//TODO navigation animations not works
