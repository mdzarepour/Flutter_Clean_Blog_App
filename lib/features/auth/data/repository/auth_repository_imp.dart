import 'package:blog/core/common/user/entities/user_entity.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImp({required this.authRemoteDatasource});

  @override
  Future<Either<String, UserEntity>> signupUser({
    required SignupModel signupModel,
  }) async {
    try {
      final AuthResponse authResponse = await authRemoteDatasource.signupUser(
        signupModel: signupModel,
      );
      if (authResponse.user == null) return left('account don\'t created!');
      final UserModel userModel = UserModel.fromResponse(
        user: authResponse.user!,
      );
      return right(userModel.toEntity());
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
      if (authResponse.user == null) {
        return left('cant login now');
      }
      final userModel = UserModel.fromResponse(user: authResponse.user!);
      authRemoteDatasource.saveUserInDB(userModel: userModel);
      return right(userModel.toEntity());
    } on PostgrestException catch (e) {
      return left(e.message.toString());
    } on AuthException catch (e) {
      return left(e.message.toString());
    }
  }

  @override
  Future<Either<String, UserEntity?>> getCurrentUser() async {
    try {
      final Map? userData = await authRemoteDatasource.getCurrentUserFromDB();
      if (userData == null || userData.isEmpty) {
        return left('user not exist');
      }
      final UserModel userModel = UserModel.fromJson(map: userData);

      return right(userModel.toEntity());
    } on PostgrestException catch (e) {
      return left(e.toString());
    }
  }
}
