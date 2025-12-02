import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/domain/usecases/signin_usecase.dart';
import 'package:blog/features/auth/domain/usecases/signup_usecase.dart';
import 'package:blog/features/auth/presentation/bloc/status/signin_status.dart';
import 'package:blog/features/auth/presentation/bloc/status/signup_status.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase signupUsecase;
  final SigninUsecase signinUsecase;
  AuthBloc({required this.signinUsecase, required this.signupUsecase})
    : super(
        AuthState(signupStatus: SignupInitial(), signinStatus: SigninInitial()),
      ) {
    on<SignupEvent>(signup);
    on<SigninEvent>(signin);
  }

  FutureOr<void> signin(event, emit) async {
    emit(state.coptyWith(newSigninStatus: SigninLoading()));
    final Either either = await signinUsecase.call(params: event.signinModel);
    either.fold(
      (errorMessage) {
        emit(
          state.coptyWith(
            newSigninStatus: SigninFail(errorMessage: errorMessage),
          ),
        );
        emit(state.coptyWith(newSigninStatus: SigninInitial()));
      },
      (userEntity) {
        emit(
          state.coptyWith(
            newSigninStatus: SigninSuccess(userEntity: userEntity),
          ),
        );
      },
    );
  }

  FutureOr<void> signup(event, emit) async {
    emit(state.coptyWith(newSignupStatus: SignupLoading()));
    final Either either = await signupUsecase.call(params: event.signupModel);
    either.fold(
      (errorMessage) {
        emit(
          state.coptyWith(
            newSignupStatus: SignupFail(errorMessage: errorMessage),
          ),
        );
        emit(state.coptyWith(newSignupStatus: SignupInitial()));
      },
      (response) {
        emit(
          state.coptyWith(
            newSignupStatus: SignupSuccess(authResponse: response),
          ),
        );
      },
    );
  }
}
