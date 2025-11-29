import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SigninUsecase
    implements Usecase<Future<Either<String, AuthResponse>>, SigninModel> {
  final AuthRepository authRepository;
  SigninUsecase({required this.authRepository});

  @override
  Future<Either<String, AuthResponse>> call({
    required SigninModel params,
  }) async {
    return await authRepository.signinUser(signinModel: params);
  }
}
