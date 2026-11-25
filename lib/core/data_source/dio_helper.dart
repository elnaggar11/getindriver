import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/shared/widgets/myLoading.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../Router/Router.dart';
import '../Router/navigation_helper.dart';
import '../localization/localization_helper.dart';
import '../services/alerts.dart';
import '../utils/utils.dart';

class DioService {
  late final Dio _dio;
  final String baseUrl;

  DioService([this.baseUrl = '']) {
    _dio =
        Dio(
            BaseOptions(
              baseUrl: baseUrl,
              validateStatus: (status) => status != null && status < 400,
              followRedirects: true, // دع Dio يتعامل مع عمليات إعادة التوجيه
              headers: _getDefaultHeaders(),
              receiveDataWhenStatusError: true,
              connectTimeout: const Duration(seconds: 60),
              receiveTimeout: const Duration(seconds: 60),
            ),
          )
          ..interceptors.addAll(
            (!kReleaseMode)
                ? [
                    PrettyDioLogger(
                      requestHeader: false,
                      requestBody: false,
                      responseBody: false,
                      error: true,
                      compact: true,
                      maxWidth: 90,
                    ),
                  ]
                : [],
          );
  }

  Map<String, dynamic> _getDefaultHeaders() {
    return {
      "Accept": "application/json",
      "lang": LocalizationHelper.currentLocale.languageCode,
      "Accept-Language": LocalizationHelper.currentLocale,
      //"lang": "en",
    };
  }

  void _updateHeaders({
    required String method,
    bool isFile = false,
    Map<String, dynamic>? extraHeaders,
  }) {
    final defaultHeaders = _getDefaultHeaders();
    _dio.options.headers = {
      ...defaultHeaders,
      ...?extraHeaders,

      if (Utils.token.isNotEmpty) "Authorization": 'Bearer ${Utils.token}',
      // if (Utils.userModel..isNotEmpty) "Authorization": 'Bearer ${Utils.token}',
    };

    // تجنب إضافة Content-Type لطلبات GET
    if (method.toUpperCase() != 'GET') {
      if (isFile) {
        // هذا الشرط سيتحقق فقط لطلبات POST أو PUT التي تحتوي على ملفات
        _dio.options.headers["Content-Type"] = "multipart/form-data";
      } else {
        // هنا يمكنك تعيين Content-Type الافتراضي للطلبات التي لا تحتوي على ملفات
        // مثل "application/json" إذا كان الـ backend يتوقع ذلك
        _dio.options.headers["Content-Type"] = "application/json";
      }
    }
  }

  Future<ApiResponse<T?>> _request<T>({
    required String method,
    required String url,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? parser,
    Map<String, dynamic>? query,
    Map<String, dynamic>? extraHeaders,
    bool loading = false,
    bool isForm = false,
    bool isFile = false,
  }) async {
    try {
      if (loading) MyLoading.show();

      _updateHeaders(
        method: method,
        isFile: isFile,
        extraHeaders: extraHeaders,
      );
      final data = isForm ? FormData.fromMap(body ?? {}) : body;

      late Response response;
      // DNS lookups can fail briefly on iOS when the network changes. Retry
      // connection errors before surfacing them to the caller.
      for (var attempt = 0; ; attempt++) {
        try {
          response = await _dio.request(
            url,
            options: Options(method: method),
            data: data,
            queryParameters: query,
          );
          break;
        } on DioException catch (e) {
          if (e.type != DioExceptionType.connectionError || attempt >= 2) {
            rethrow;
          }
          await Future<void>.delayed(Duration(milliseconds: 400 * (attempt + 1)));
        }
      }

      if (loading) MyLoading.dismis();
      return _checkForSuccess<T?>(response, parser);
    } on DioException catch (e, t) {
      print("dio_service_error$e");
      print("dio_service_error$t");
      if (loading) MyLoading.dismis();
      var response = _handleDioException<T?>(e);
      return ApiResponse(
        isError: true,
        response: response.response,
        model: null,
        message: response.message,
      );
    } catch (e, t) {
      // للتعامل مع أي أخطاء أخرى غير متوقعة
      if (loading) MyLoading.dismis();
      print("dio_service_error2$e");
      print("dio_service_error2$t");
      log("Unhandled Error: $e", name: "dio_service_error");
      Alerts.snack(
        text: LocalizationHelper.tr.unknownError,
        state: SnackState.failed,
      );
      return ApiResponse(isError: true, model: null, message: e.toString());
    }
  }

  Future<ApiResponse<T?>> postData<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    bool loading = false,
    bool isForm = false,
    bool isFile = false,
    Map<String, dynamic>? extraHeaders,
    T Function(Map<String, dynamic>)? parser,
  }) {
    return _request<T?>(
      method: "POST",
      url: url,
      body: body,
      query: query,
      loading: loading,
      isForm: isForm,
      isFile: isFile,
      extraHeaders: extraHeaders,
      parser: parser,
    );
  }

  Future<ApiResponse<T?>> putData<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? extraHeaders,
    bool loading = false,
    bool isForm = false,
    T Function(Map<String, dynamic>)? parser,
  }) {
    return _request<T?>(
      method: "PUT",
      url: url,
      body: body,
      parser: parser,
      query: query,
      loading: loading,
      extraHeaders: extraHeaders,
      isForm: isForm,
    );
  }

  Future<ApiResponse<T?>> deleteData<T>({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? extraHeaders,
    T Function(Map<String, dynamic>)? parser,
    bool loading = false,
  }) {
    return _request<T?>(
      method: "DELETE",
      url: url,
      query: query,
      extraHeaders: extraHeaders,
      loading: loading,
      parser: parser,
    );
  }

  Future<ApiResponse<T?>> getData<T>({
    required String url,
    Map<String, dynamic>? query,
    T Function(Map<String, dynamic>)? parser,
    Map<String, dynamic>? extraHeaders,
    bool loading = false,
  }) {
    return _request<T?>(
      method: "GET",
      url: url,
      query: query,
      loading: loading,
      extraHeaders: extraHeaders,
      parser: parser,
    );
  }

  Future<ApiResponse<T?>> _checkForSuccess<T>(
    Response response,
    T? Function(Map<String, dynamic>)? parser,
  ) async {
    final bool status = response.data is Map
        ? (response.data["status"] == "success" || response.data["status"] ??
              false)
        : false;
    final String message = response.data is Map
        ? response.data["message"] ?? "No message from server"
        : "Invalid response format";

    try {
      if (status) {
        T? model;
        if (parser != null && response.data is Map<String, dynamic>) {
          // run parser in isolate
          model = await compute(
            _parserWorker,
            _ParserInput(parser, response.data),
          );
        }

        return ApiResponse<T?>(
          isError: false,
          response: response,
          model: model,
          message: message,
        );
      } else {
        Alerts.snack(text: message, state: SnackState.failed);
        return ApiResponse<T?>(
          isError: true,
          response: response,
          model: null,
          message: message,
        );
      }
    } catch (e, trace) {
      log("Error: $e", name: "model_error");
      log("Trace: $trace", name: "model_trace");
      Alerts.snack(
        text: LocalizationHelper.tr.unknownError,
        state: SnackState.failed,
      );
      return ApiResponse<T?>(
        isError: true,
        response: response,
        model: null,
        message: e.toString(),
      );
    }
  }

  ApiResponse<T?> _handleDioException<T>(DioException e) {
    String errorMessage = LocalizationHelper.tr.unknownError;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        errorMessage = LocalizationHelper.tr.connectionTimeout;
        break;
      case DioExceptionType.badResponse:
        if (e.response?.data is! Map) {
          errorMessage = e.response?.data ?? LocalizationHelper.tr.serverError;
        }
        errorMessage =
            e.response?.data["message"] ?? LocalizationHelper.tr.serverError;
        if (errorMessage.contains("Unauthenticated") ||
            e.response?.statusCode == 401) {
          _handleUnauthenticated();
        }
        break;
      case DioExceptionType.connectionError:
        errorMessage = LocalizationHelper.tr.noNetwork;
        break;
      case DioExceptionType.unknown:
        // التعامل مع الأخطاء غير المعروفة بشكل صريح
        errorMessage = LocalizationHelper.tr.unknownError;
        log("DioException.unknown: ${e.message}", name: "dio_error");
        break;
      case DioExceptionType.cancel:
        errorMessage = LocalizationHelper.tr.requestCanceled;
        break;
      case DioExceptionType.badCertificate:
        errorMessage = LocalizationHelper.tr.badCertificate;
        break;
    }

    Alerts.snack(text: errorMessage, state: SnackState.failed);
    return ApiResponse(
      isError: true,
      response: e.response,
      model: null,
      message: errorMessage,
    );
  }

  void _handleUnauthenticated() async {
    await Utils.dataManager.deleteUserData();
    if (!NavigationService.context.mounted) return;
    NavigationService.pushNamedReplaceAll(Routes.loginSignupToggleScreen);
  }
}

class ApiResponse<T> {
  final bool isError;
  final String? message;
  final Response? response;
  final T? model;

  ApiResponse({required this.isError, this.response, this.model, this.message});
}

class _ParserInput<T> {
  final T Function(Map<String, dynamic>) parser;
  final Map<String, dynamic> data;
  _ParserInput(this.parser, this.data);
}

T _parserWorker<T>(_ParserInput<T> input) {
  return input.parser(input.data);
}
