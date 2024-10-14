import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test_project/core/extension/dio_extension.dart';
import 'package:todo_test_project/core/router/router.dart';
import 'package:todo_test_project/core/utils/utils.dart';

import '../extension/shared_preferences_manager.dart';

GetIt locator = GetIt.instance;
setupInjection() async {
  await provideSharedPreferences();
  provideSharedPreferencesManager();
}

void provideSharedPreferencesManager() {
  final sharedPreferencesManager = SharedPreferencesManager(locator());
  locator.registerSingleton<SharedPreferencesManager>(sharedPreferencesManager);
}

Future<void> provideSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
}

void provideDioBaseOptions() {
  BaseOptions options = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 50),
    receiveTimeout: const Duration(seconds: 50),
  );
  locator.registerLazySingleton<BaseOptions>(() => options);
}

void provideDio() {
  final Dio dio = Dio(locator());
  int numberOfTry = 0;
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  };
  dio.interceptors.add(
    InterceptorsWrapper(
      onResponse: (response, handler) {
        if (response.statusCode == 200) {
          numberOfTry = 0;
        }
        return handler.next(response);
      },
      onError: (e, handler) async {
        if ((e.error is SocketException ||
                e.type == DioExceptionType.unknown ||
                e.isNoConnectionError ||
                (e.message?.contains('404') ?? false)) &&
            (e.requestOptions.method.contains('GET'))) {
          if (numberOfTry == 10 ||
              numberOfTry == 50 ||
              numberOfTry == 150 ||
              numberOfTry == 350) {
            if (NavigationService.navigatorKey.currentContext != null) {
              Utils.showSnack(
                  message: 'connectionError',
                  context: NavigationService.navigatorKey.currentContext!);
            }
          }
          numberOfTry++;
          await Future.delayed(const Duration(seconds: 3));
          return handler.resolve(await dio.fetch(e.requestOptions));
        }
        // if (e.response?.statusCode == 403 || e.response?.statusCode == 401) {
        //   sharedPreferencesManager.clearToken();
        //   // If a 401 response is received, refresh the access token

        //   if (sharedPreferencesManager.getRefreshToken()?.isNotEmpty ?? false) {
        //     String? newAccessToken = await Utils.refreshToken();
        //     if (newAccessToken?.isNotEmpty ?? false) {
        //       // Update the request header with the new access token
        //       e.requestOptions.headers['Authorization'] =
        //           'Bearer $newAccessToken';

        //       // Repeat the request with the updated header
        //       return handler.resolve(await dio.fetch(e.requestOptions));
        //     }
        //   }

        // }
        return handler.next(e);
      },
    ),
  );
  locator.registerLazySingleton<Dio>(() => dio);
}
