import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:blog/features/auth/domain/entities/user_entity.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthResponse, AuthException;

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImp({required this.authRemoteDatasource});

  @override
  Future<Either<String, AuthResponse>> signupUser({
    required SignupModel signupModel,
  }) async {
    try {
      final AuthResponse authResponse = await authRemoteDatasource.signupUser(
        signupModel: signupModel,
      );
      if (authResponse.user == null) return left('account don\'t created!');
      return right(authResponse);
    } on AuthException catch (e) {
      return left(e.message.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> signinUser({
    required SigninModel signinModel,
  }) async {
    try {
      final AuthResponse authResponse = await authRemoteDatasource.signinUser(
        signinModel: signinModel,
      );
      if (authResponse.user == null) return left('cant login now');
      final UserModel userModel = UserModel.fromJson(
        map: authResponse.user!.toJson(),
      );

      return right(userModel.toEntity());
    } on AuthException catch (e) {
      return left(e.message.toString());
    }
  }
}
