import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';

import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupUsecase
    implements Usecase<Future<Either<String, AuthResponse>>, SignupModel> {
  final AuthRepository authRepository;
  SignupUsecase({required this.authRepository});

  @override
  Future<Either<String, AuthResponse>> call({
    required SignupModel params,
  }) async {
    return await authRepository.signupUser(signupModel: params);
  }
}
