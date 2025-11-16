import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';

import 'package:fpdart/fpdart.dart';

class SignupUsecase implements Usecase<Future<Either>, SignupModel> {
  final AuthRepository authRepository;
  SignupUsecase({required this.authRepository});

  @override
  Future<Either> call({required SignupModel params}) async {
    return await authRepository.signupUser(signupModel: params);
  }
}
