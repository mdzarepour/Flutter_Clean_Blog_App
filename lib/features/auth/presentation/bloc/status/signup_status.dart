import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SignupStatus {}

class SignupInitial extends SignupStatus {}

class SignupLoading extends SignupStatus {}

class SignupSuccess extends SignupStatus {
  final AuthResponse authResponse;
  SignupSuccess({required this.authResponse});
}

class SignupFail extends SignupStatus {
  final String errorMessage;
  SignupFail({required this.errorMessage});
}
