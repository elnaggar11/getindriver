import 'package:getin_driver/features/client_map/domain/repository/repository.dart';
import 'package:getin_driver/features/qr_reader/domain/repository/repository.dart';

import 'package:getin_driver/features/order_map/domain/repository/repository.dart';
import 'package:getin_driver/features/static_pages/domain/repositories/pages_repo.dart';

import '../../features/edit_profile/domain/repository/repository.dart';
import '../../features/profile/domain/repository/repository.dart';
import '../../features/report/domain/repository/repository.dart';
import '../../features/finance/domain/repository/repository.dart';
import '../../features/order_details/domain/repository/repository.dart';
import '../../features/home/domain/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/utils/validations.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/splash/domain/repository/splash_repository.dart';
import '../Router/Router.dart';
import '../config/key.dart';
import '../data_source/dio_helper.dart';
import '../data_source/hive_helper.dart';
import '../general/general_cubit.dart';
import '../services/media/my_media.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => DataManager());
  locator.registerLazySingleton(() => DioService(ConstKeys.baseUrl));
  locator.registerLazySingleton(() => Routes());
  locator.registerLazySingleton(() => GeneralCubit());
  locator.registerLazySingleton(
    () => QrReaderRepository(locator<DioService>()),
  );
  locator.registerLazySingleton(
    () => StaticRepositories(locator<DioService>()),
  );

  locator.registerLazySingleton(() => Validation());
  locator.registerLazySingleton(() => MediaService());
  locator.registerLazySingleton(() => GlobalKey<ScaffoldState>());
  locator.registerLazySingleton(() => GlobalKey<NavigatorState>());
  locator.registerLazySingleton(() => AuthRepository(locator<DioService>()));
  locator.registerLazySingleton(() => SplashRepository(locator<DioService>()));
  locator.registerLazySingleton(
    () => BranchMapRepository(locator<DioService>()),
  );
  locator.registerLazySingleton(
    () => ClientOrderMapRepository(locator<DioService>()),
  );

  locator.registerLazySingleton(() => HomeRepository(locator<DioService>()));

  locator.registerLazySingleton(
    () => OrderDetailsRepository(locator<DioService>()),
  );

  locator.registerLazySingleton(() => FinanceRepository(locator<DioService>()));

  locator.registerLazySingleton(() => ReportRepository(locator<DioService>()));

  locator.registerLazySingleton(() => ProfileRepository(locator<DioService>()));

  locator.registerLazySingleton(
    () => EditProfileRepository(locator<DioService>()),
  );
}
