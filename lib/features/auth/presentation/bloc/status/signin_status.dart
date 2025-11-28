import 'package:blog/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SigninStatus {}

class SigninInitial extends SigninStatus {}

class SigninLoading extends SigninStatus {}

class SigninSuccess extends SigninStatus {
  final UserEntity userEntity;
  SigninSuccess({required this.userEntity});
}

class SigninFail extends SigninStatus {
  final String errorMessage;
  SigninFail({required this.errorMessage});
}
