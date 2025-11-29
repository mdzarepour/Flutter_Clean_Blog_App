import 'package:blog/core/common/user/user_entity.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetCurrentUserUsecase
    implements Usecase<Future<Either<String, UserEntity?>>, NoParams> {
  final AuthRepository authRepository;
  GetCurrentUserUsecase({required this.authRepository});

  @override
  Future<Either<String, UserEntity?>> call({required NoParams params}) async {
    return await authRepository.getCurrentUser();
  }
}
