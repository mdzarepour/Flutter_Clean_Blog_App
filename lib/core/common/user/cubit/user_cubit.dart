import 'package:bloc/bloc.dart';
import 'package:blog/core/common/user/user_entity.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  UserCubit({required this.getCurrentUserUsecase}) : super(UserNotExist());

  void getCurrentUser() async {
    emit(UserLoading());
    final Either either = await getCurrentUserUsecase.call(params: NoParams());
    either.fold(
      (errorMessage) {
        emit(UserNotExist(errorMessage: errorMessage));
      },
      (user) {
        emit(UserExist(userEntity: user));
      },
    );
  }
}
