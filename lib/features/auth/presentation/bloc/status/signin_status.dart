import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SigninStatus {}

class SigninInitial extends SigninStatus {}

class SigninLoading extends SigninStatus {}

class SigninSuccess extends SigninStatus {
  final AuthResponse authResponse;
  SigninSuccess({required this.authResponse});
}

class SigninFail extends SigninStatus {
  final String errorMessage;
  SigninFail({required this.errorMessage});
}
