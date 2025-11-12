import 'package:blog/app_secrets.dart';
import 'package:blog/core/theme/app_theme.dart';
import 'package:blog/locator.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //   theme: AppTheme.darkTheme,
      home: Scaffold(body: Center(child: Text('data'))),
    );
  }
}
