import 'dart:developer';

import 'package:blog/core/router/router.dart';
import 'package:blog/core/services/services.dart';
import 'package:blog/core/services/snackbar_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // helper classes -->
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(
    () => AppRouter(snackbarService: locator.get()).router,
  );
}
