

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat/data/dataSource/remote/dio/dio_client.dart';
import 'package:zakat/data/dataSource/remote/dio/logging_interceptor.dart';
import 'package:zakat/services/wallet_service.dart';
import 'package:zakat/data/repos/auth_repo.dart';
import 'package:zakat/data/repos/wallet_repo.dart';
import 'package:zakat/utils/api_end_points.dart';

final sl = GetIt.I;

Future<void> init() async {
  try {
    print('Starting DI initialization...');

    // External dependencies first
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
    print('✓ SharedPreferences registered');

  sl.registerLazySingleton(() => Dio());
    print('✓ Dio registered');

  sl.registerLazySingleton(() => LoggingInterceptor());
    print('✓ LoggingInterceptor registered');

    // Then register DioClient which depends on the above
    sl.registerLazySingleton<DioClient>(() {
      print('Creating DioClient...');
      return DioClient(
      ApiEndPoints.baseUrl,
        sl<Dio>(),
        loggingInterceptor: sl<LoggingInterceptor>(),
        sharedPreferences: sl<SharedPreferences>(),
      );
    });
    print('✓ DioClient registered');

    // Finally register repositories that depend on DioClient
  sl.registerLazySingleton(
      () => AuthRepo(
        dioClient: sl<DioClient>(),
        sharedPreferences: sl<SharedPreferences>(),
      ),
  );

    print('✓ AuthRepo registered');

  sl.registerLazySingleton(
    () => WalletRepo(
      dioClient: sl<DioClient>(),
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );
  print('✓ WalletRepo registered');

    print('DI initialization completed successfully');

    sl.registerLazySingleton(() => WalletService(
      projectId: '42a9d4d42e05881a8053ce1ab874be1b',
      userId: 'user123', // You'll need to get this from your auth system
      authToken: 'your_auth_token', // You'll need to get this from your auth system
      backendApiUrl: ApiEndPoints.baseUrl,
      walletRepo: sl(),
    ));
  } catch (e, stackTrace) {
    print('Error during DI initialization: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}
