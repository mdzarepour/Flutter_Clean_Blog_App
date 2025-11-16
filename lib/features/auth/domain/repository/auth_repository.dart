import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either> signupUser({required SignupModel signupModel});
  Future<Either> signinUser({required SigninModel signinModel});
}
