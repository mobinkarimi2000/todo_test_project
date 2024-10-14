import 'dart:io';
import 'package:dio/dio.dart';

extension DioErrorX on DioException {
  bool get isNoConnectionError =>
      type == DioExceptionType.unknown && error is SocketException;

  bool get isTimedOut =>
      type == DioExceptionType.connectionTimeout ||
      type == DioExceptionType.sendTimeout ||
      type == DioExceptionType.receiveTimeout;
}
