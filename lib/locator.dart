import 'package:blog/core/common/constants/app_secrets.dart';
import 'package:blog/core/common/user/cubit/user_cubit.dart';
import 'package:blog/core/router/router.dart';
import 'package:blog/core/services/widget_service.dart';
import 'package:blog/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/repository/auth_repository_imp.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:blog/features/auth/domain/usecases/signin_usecase.dart';
import 'package:blog/features/auth/domain/usecases/signup_usecase.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;

setupLocator() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );

  // Register external dependencies
  locator.registerLazySingleton<SupabaseClient>(() => supabase.client);

  // Register helper classes
  locator
    ..registerLazySingleton(() => WidgetServices())
    ..registerLazySingleton(() {
      return AppRouter(
        userCubit: locator.get(),
        snackbarService: locator.get(),
      ).router;
    });

  // Register data sources
  locator
    ..registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImp(supabase: locator.get()),
    )
    ..registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasourceImp(supabase: locator.get()),
    );

  // Register repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      authRemoteDatasource: locator.get(),
      authLocalDatasource: locator.get(),
    ),
  );

  // Register use cases
  locator
    ..registerLazySingleton(() => SignupUsecase(authRepository: locator.get()))
    ..registerLazySingleton(() => SigninUsecase(authRepository: locator.get()))
    ..registerLazySingleton(() {
      return GetCurrentUserUsecase(authRepository: locator.get());
    });

  // Register blocs
  locator
    ..registerFactory(() {
      return AuthBloc(
        signinUsecase: locator.get(),
        signupUsecase: locator.get(),
      );
    })
    ..registerFactory(() {
      return UserCubit(getCurrentUserUsecase: locator.get());
    });
}
