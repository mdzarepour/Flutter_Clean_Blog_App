part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [UnimplementedError()];
}

final class UserLoading extends UserState {}

final class UserExist extends UserState {
  final UserEntity? userEntity;
  const UserExist({this.userEntity});
}

final class UserNotExist extends UserState {
  final String? errorMessage;
  const UserNotExist({this.errorMessage});
}
