import 'package:blog/common/constants/app_secrets.dart';
import 'package:blog/common/theme/app_theme.dart';
import 'package:blog/core/router/router.dart';
import 'package:blog/locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );
  setupLocator();
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: locator.get<GoRouter>(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
    );
  }
}

//TODO turn on keep alive in onboarding page
//TODO use go router for navigations
