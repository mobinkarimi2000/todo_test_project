import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_test_project/core/extension/dio_extension.dart';
import 'package:todo_test_project/core/utils/constants.dart';
import 'package:go_router/go_router.dart';
import '../error_handling/custom_exception.dart';
import '../error_handling/failure.dart';
import '../widgets/custom_elevated_button.dart';

class Utils {
  static void showConfirmDialog({
    required String message,
    required String title,
    required Function() onConfirm,
    required Function() onRefresh,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) => ScaffoldMessenger(
        child: Builder(builder: (context) {
          final theme = Theme.of(context);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {}
                },
                child: Dialog(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  surfaceTintColor: theme.scaffoldBackgroundColor,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  insetPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (title.isNotEmpty)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.grey.shade800),
                                        ),
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                      width: double.infinity,
                                      height: 2,
                                      color: Colors.grey.shade700),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(message,
                                          style: const TextStyle(color: Colors.grey)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: CustomElevatedButton(
                                        backgroundColor: Colors.blue,
                                        onTap: () async {
                                          context.pop();
                                          onConfirm();
                                        },
                                        child: const Text(
                                          "confirm",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        backgroundColor: Colors.red,
                                        onTap: () async {
                                          context.pop();
                                        },
                                        child: const Text(
                                          "cancel",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    ).then((value) {
      onRefresh();
    });
  }

  static void showSnack({
    required String message,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.red,
        backgroundColor: theme.scaffoldBackgroundColor,
        duration: const Duration(seconds: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 12, color: theme.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static handleUnknownException(Object e) {
    if (e is CancelByUserException) {
      return CancelByUserFailure();
    }
    if (e is TypeError) {
      return TypeErrorFailure(message: e.toString());
    }

    return UnknownFailure();
  }

  static handleDioException(DioException e) {
    if (e.isNoConnectionError) {
      throw NoInternetConnectionException();
    } else if (e.response != null) {
      throw RestApiException(
          e.response?.statusCode, (e.response ?? e.message).toString());
    } else if (e.type == DioExceptionType.cancel) {
      throw CancelByUserException(errorMessage: e.message, errorCode: 499);
    } else if (e.type == DioExceptionType.cancel) {
      throw CancelByUserException();
    } else {
      throw UnknownException();
    }
  }

  static handleRestApiException(RestApiException e) {
    if (e.errorCode != null) {
      if (e.errorCode! >= RestApiError.FROM_SERVER_ERROR &&
          e.errorCode! <= RestApiError.TO_SERVER_ERROR) {
        return ServerErrorFailure(
            errorCode: e.errorCode, message: e.errorMessage);
      }
      if (e.errorCode! == 403 || e.errorCode == 401) {
        return UnauthorizedFailure(
            errorCode: e.errorCode, message: e.errorMessage);
      }
      return UnknownFailure(errorCode: e.errorCode, message: e.errorMessage);
    } else {
      return UnknownFailure(errorCode: e.errorCode, message: e.errorMessage);
    }
  }
}
