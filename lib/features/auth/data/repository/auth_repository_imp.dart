import 'package:blog/core/common/user/user_entity.dart';
import 'package:blog/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;
  AuthRepositoryImp({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

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
  Future<Either<String, AuthResponse>> signinUser({
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
      authLocalDatasource.saveUserInDB(userModel: userModel);
      return right(authResponse);
    } on PostgrestException catch (e) {
      return left(e.message.toString());
    } on AuthException catch (e) {
      return left(e.message.toString());
    }
  }

  @override
  Future<Either<String, UserEntity?>> getCurrentUser() async {
    try {
      final UserModel? userModel = await authLocalDatasource
          .getCurrentUserFromDB();
      if (userModel?.id == null || userModel?.id == '') {
        return left('user not exist');
      }
      return right(userModel!.toEntity());
    } on PostgrestException catch (e) {
      return left(e.toString());
    }
  }
}
