import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/data/models/user_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<AuthResponse> signupUser({required SignupModel signupModel});
  Future<AuthResponse> signinUser({required SigninModel signinModel});
  Future<Map?> saveUserInDB({required final UserModel userModel});
  Future<Map?> getCurrentUserFromDB();
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

  @override
  saveUserInDB({required UserModel userModel}) async {
    try {
      final userData = await supabase.from('users').upsert({
        'id': userModel.id,
        'created_at': userModel.createdAt,
        'updated_at': userModel.updatedAt,
        'email': userModel.email,
        'username': userModel.username,
        'password': userModel.password,
      }).select();
      return userData.first;
    } on PostgrestException {
      rethrow;
    }
  }

  @override
  Future<Map?> getCurrentUserFromDB() async {
    try {
      final Session? session = supabase.auth.currentSession;
      if (session == null) {
        return null;
      }
      final List<Map> userData = await supabase
          .from('users')
          .select()
          .eq('id', session.user.id);
      return userData.first;
    } catch (e) {
      rethrow;
    }
  }
}
