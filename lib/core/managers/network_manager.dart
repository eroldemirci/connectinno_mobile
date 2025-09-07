import 'package:connectinno_case/core/managers/auth_manager/auth_manager.dart';
import 'package:connectinno_case/core/routing/routing.gr.dart';
import 'package:connectinno_case/core/shared/env.dart';
import 'package:connectinno_case/main.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();
  factory NetworkManager() => _instance;
  late final Dio dio;

  static const Map<String, String> _defaultHeaders = {'Content-Type': 'application/json', 'Accept': 'application/json'};

  NetworkManager._internal() {
    dio = Dio(BaseOptions(headers: _defaultHeaders, connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 15)));
    dio.interceptors.add(_CustomInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true, responseBody: true, error: true, compact: true, maxWidth: 120),
    );
  }

  String _fullUrl(String endpoint) {
    return Env.baseUrl + endpoint;
  }

  Future<Response<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await dio.get<T>(
      _fullUrl(endpoint),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String endpoint, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await dio.post<T>(
      _fullUrl(endpoint),
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> put<T>(
    String endpoint, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await dio.put<T>(
      _fullUrl(endpoint),
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> delete<T>(String endpoint, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    return await dio.delete<T>(_fullUrl(endpoint), data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
  }
}

class _CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final user = AuthManager.instance.user;
    final token = user?.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await AuthManager.instance.logout();
      MainApp.appRouter.replaceAll([const LoginRoute()]);
    }
    super.onError(err, handler);
  }
}
