import 'package:blog/core/common/user/entities/user_entity.dart';

abstract class SignupStatus {}

class SignupInitial extends SignupStatus {}

class SignupLoading extends SignupStatus {}

class SignupSuccess extends SignupStatus {
  final UserEntity userEntity;
  SignupSuccess({required this.userEntity});
}

class SignupFail extends SignupStatus {
  final String errorMessage;
  SignupFail({required this.errorMessage});
}
