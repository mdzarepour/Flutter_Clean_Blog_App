import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/core/common/user/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<String, UserEntity>> signupUser({
    required SignupModel signupModel,
  });
  Future<Either<String, UserEntity>> signinUser({
    required SigninModel signinModel,
  });
  Future<Either<String, UserEntity?>> getCurrentUser();
}
