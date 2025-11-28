import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRepository {
  Future<Either<String, AuthResponse>> signupUser({
    required SignupModel signupModel,
  });
  Future<Either<String, UserEntity>> signinUser({
    required SigninModel signinModel,
  });
}
