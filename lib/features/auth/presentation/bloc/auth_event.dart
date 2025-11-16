part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object> get props => [UnimplementedError()];
}

class SignupEvent extends AuthEvent {
  final SignupModel signupModel;
  SignupEvent({required this.signupModel});
}

class SigninEvent extends AuthEvent {
  final SigninModel signinModel;
  SigninEvent({required this.signinModel});
}
