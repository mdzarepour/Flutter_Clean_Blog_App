part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final SignupStatus signupStatus;
  final SigninStatus signinStatus;
  const AuthState({required this.signupStatus, required this.signinStatus});

  AuthState coptyWith({
    SignupStatus? newSignupStatus,
    SigninStatus? newSigninStatus,
  }) {
    return AuthState(
      signupStatus: newSignupStatus ?? signupStatus,
      signinStatus: newSigninStatus ?? signinStatus,
    );
  }

  @override
  List<Object> get props => [signupStatus, signinStatus];
}
