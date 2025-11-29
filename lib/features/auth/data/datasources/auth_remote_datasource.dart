import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<AuthResponse> signupUser({required SignupModel signupModel});
  Future<AuthResponse> signinUser({required SigninModel signinModel});
}

class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  final SupabaseClient supabase;
  AuthRemoteDatasourceImp({required this.supabase});

  @override
  Future<AuthResponse> signupUser({required SignupModel signupModel}) async {
    try {
      final AuthResponse authResponse = await supabase.auth.signUp(
        email: signupModel.email,
        password: signupModel.password,
        data: {
          'username': signupModel.username,
          'password': signupModel.password,
        },
      );
      return authResponse;
    } on AuthException {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> signinUser({required SigninModel signinModel}) async {
    try {
      final AuthResponse authResponse = await supabase.auth.signInWithPassword(
        email: signinModel.email,
        password: signinModel.password,
      );

      return authResponse;
    } on AuthException {
      rethrow;
    }
  }
}
