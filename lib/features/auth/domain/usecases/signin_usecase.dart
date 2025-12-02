import 'package:blog/core/common/user/entities/user_entity.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SigninUsecase
    implements Usecase<Future<Either<String, UserEntity>>, SigninModel> {
  final AuthRepository authRepository;
  SigninUsecase({required this.authRepository});

  @override
  Future<Either<String, UserEntity>> call({required SigninModel params}) async {
    return await authRepository.signinUser(signinModel: params);
  }
}
