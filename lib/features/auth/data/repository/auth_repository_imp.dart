import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImp({required this.authRemoteDatasource});

  @override
  Future<Either> signupUser({required SignupModel signupModel}) async {
    try {
      final AuthResponse authResponse = await authRemoteDatasource.signupUser(
        signupModel: signupModel,
      );
      if (authResponse.user != null) {
        return right(authResponse);
      }
      return left('account don\'t created!');
    } on AuthException catch (e) {
      return left(e.message.toString());
    }
  }

  @override
  Future<Either> signinUser({required SigninModel signinModel}) async {
    try {
      final AuthResponse authResponse = await authRemoteDatasource.signinUser(
        signinModel: signinModel,
      );
      if (authResponse.user != null) {
        return right(authResponse);
      }
      return left('cant login now');
    } on AuthException catch (e) {
      return left(e.message.toString());
    }
  }
}
