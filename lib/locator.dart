import 'package:blog/common/constants/app_secrets.dart';
import 'package:blog/core/router/router.dart';
import 'package:blog/core/services/snackbar_service.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/repository/auth_repository_imp.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
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

  //external dependencies -->
  locator.registerLazySingleton<SupabaseClient>(() => supabase.client);
  // helper classes -->
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(
    () => AppRouter(
      supabaseClient: locator.get(),
      snackbarService: locator.get(),
    ).router,
  );
  // datsources -->
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImp(supabase: locator.get()),
  );
  // repositories -->
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(authRemoteDatasource: locator.get()),
  );
  // usecase -->
  locator.registerLazySingleton(
    () => SignupUsecase(authRepository: locator.get()),
  );
  locator.registerLazySingleton(
    () => SigninUsecase(authRepository: locator.get()),
  );
  // blocs -->
  locator.registerFactory(
    () => AuthBloc(signinUsecase: locator.get(), signupUsecase: locator.get()),
  );
}
