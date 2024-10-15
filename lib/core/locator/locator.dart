import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test_project/core/extension/dio_extension.dart';
import 'package:todo_test_project/core/router/router.dart';
import 'package:todo_test_project/core/utils/utils.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/abstraction/todo_data_source.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/impl/todo_data_source_impl.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/mapper/todo_list_mapper.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/mapper/todo_mapper.dart';
import 'package:todo_test_project/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_test_project/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_test_project/features/todo/domain/usecases/add_todo_use_case.dart';
import 'package:todo_test_project/features/todo/domain/usecases/delete_todo_use_case.dart';
import 'package:todo_test_project/features/todo/domain/usecases/get_todo_list_use_case.dart';
import 'package:todo_test_project/features/todo/domain/usecases/update_todo_use_case.dart';
import 'package:todo_test_project/features/todo/presentation/controllers/todo_controller.dart';

import '../extension/shared_preferences_manager.dart';

GetIt locator = GetIt.instance;
setupInjection() async {
  await provideSharedPreferences();
  provideSharedPreferencesManager();
  provideTodo();
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

        return handler.next(e);
      },
    ),
  );
  locator.registerLazySingleton<Dio>(() => dio);
}

provideTodo() {
  //mapper
  locator.registerSingleton<TodoMapper>(TodoMapper());
  locator.registerSingleton<TodoListMapper>(TodoListMapper());

  //data source
  locator.registerSingleton<TodoDataSource>(TodoDataSourceImpl(locator()));

  //repository
  locator.registerSingleton<TodoRepository>(TodoRepositoryImpl(
    locator(),
    locator(),
    locator(),
  ));

  //usecases
  locator.registerSingleton<AddTodoListUseCase>(AddTodoListUseCase(locator()));
  locator.registerSingleton<UpdateTodoListUseCase>(
      UpdateTodoListUseCase(locator()));
  locator.registerSingleton<GetTodoListUseCase>(GetTodoListUseCase(locator()));
  locator.registerSingleton<DeleteTodoListUseCase>(
      DeleteTodoListUseCase(locator()));

  //controller
  locator.registerSingleton<TodoController>(TodoController(
    locator(),
    locator(),
    locator(),
    locator(),
  ));
}
