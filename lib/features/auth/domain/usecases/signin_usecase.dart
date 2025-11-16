import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SigninUsecase implements Usecase<Future<Either>, SigninModel> {
  final AuthRepository authRepository;
  SigninUsecase({required this.authRepository});
  @override
  Future<Either> call({required SigninModel params}) async {
    return await authRepository.signinUser(signinModel: params);
  }
}
