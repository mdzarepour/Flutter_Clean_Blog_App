import 'package:blog/core/secret/app_secrets.dart';
import 'package:blog/core/common/user/cubit/user_cubit.dart';
import 'package:blog/core/router/router.dart';
import 'package:blog/core/utils/image_helper.dart';
import 'package:blog/core/utils/widget_helper.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog/features/auth/data/repository/auth_repository_imp.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:blog/features/auth/domain/usecases/signin_usecase.dart';
import 'package:blog/features/auth/domain/usecases/signup_usecase.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/bog/data/datsources/blog_remote_datasource.dart';
import 'package:blog/features/bog/data/repository/blog_repository_imp.dart';
import 'package:blog/features/bog/domain/repository/blog_repository.dart';
import 'package:blog/features/bog/domain/usecases/publish_blog_usecase.dart';
import 'package:blog/features/bog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;

setupLocator() async {
  await _initPackages();
  _initHelperClasses();
  _initDatasources();
  _initRepositories();
  _initUsecases();
  _initBloc();
}

_initPackages() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );

  locator
    ..registerLazySingleton(() => ImagePicker())
    ..registerLazySingleton<SupabaseClient>(() => supabase.client);
}

_initHelperClasses() {
  locator
    ..registerLazySingleton(() => ImageHelper(picker: locator.get()))
    ..registerLazySingleton(() => WidgetHelper())
    ..registerLazySingleton(() {
      return AppRouter(
        userCubit: locator.get(),
        snackbarService: locator.get(),
      ).router;
    });
}

_initDatasources() {
  locator
    ..registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImp(supabase: locator.get()),
    )
    ..registerLazySingleton<BlogRemoteDatasource>(
      () => BlogRemoteDatasourceImp(supabase: locator.get()),
    );
}

_initRepositories() {
  locator
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(authRemoteDatasource: locator.get()),
    )
    ..registerLazySingleton<BlogRepository>(
      () => BlogRepositoryImp(blogRemoteDatasource: locator.get()),
    );
}

_initUsecases() {
  locator
    ..registerLazySingleton(() => SignupUsecase(authRepository: locator.get()))
    ..registerLazySingleton(() => SigninUsecase(authRepository: locator.get()))
    ..registerLazySingleton(() {
      return PublishBlogUsecase(blogRepository: locator.get());
    })
    ..registerLazySingleton(() {
      return GetCurrentUserUsecase(authRepository: locator.get());
    });
}

_initBloc() {
  locator
    ..registerFactory(() {
      return AuthBloc(
        signinUsecase: locator.get(),
        signupUsecase: locator.get(),
      );
    })
    ..registerFactory(() => UserCubit(getCurrentUserUsecase: locator.get()))
    ..registerFactory(() => BlogBloc(publishBlogUsecase: locator.get()));
}
