import 'dart:convert';
import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';

class DioConfig {
  static String _baseUrl = Endpoint.baseUrl;

  static late DioCacheManager? _dioCacheManager;

  final Connectivity _connectivity = Get.find<Connectivity>();

  static final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
    baseUrl: _baseUrl,
  );

  static Dio createDio() {
    LogUtil().loggingTest('BASE URL $_baseUrl');
    _dioCacheManager = DioCacheManager((CacheConfig(baseUrl: _baseUrl)));
    Dio dio = Dio(_baseOptions)
      ..interceptors.add(HttpFormatter())
      ..interceptors.add(_dioCacheManager!.interceptor);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  static Dio createDioWithUrl(String baseUrl) {
    LogUtil().loggingTest('BASE URL => $baseUrl');
    _dioCacheManager = DioCacheManager((CacheConfig(baseUrl: baseUrl)));

    BaseOptions _options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      baseUrl: baseUrl,
    );

    Dio dio = Dio(_options)
      ..interceptors.add(HttpFormatter())
      ..interceptors.add(_dioCacheManager!.interceptor);
    dio.options.headers['Content-Type'] = 'application/json';

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  static Dio createDioWithForm() {
    LogUtil().loggingTest('BASE URL $_baseUrl');
    Dio dio = Dio(BaseOptions(
        connectTimeout: 30000, receiveTimeout: 30000, baseUrl: _baseUrl));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';

    return dio;
  }

  static requestInterceptorMultipart(RequestOptions options, bool isRequireAuth,
      RequestInterceptorHandler handler) async {
    options.responseType = ResponseType.json;
    String? token;
    if (isRequireAuth) {
      token = PreferenceUtils().getUserToken();
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  static Dio addInterceptors({required Dio dio, bool isRequireAuth = true}) {
    return dio
      ..interceptors.add(_dioCacheManager!.interceptor)
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (
            RequestOptions options,
            RequestInterceptorHandler requestInterceptorHandler,
          ) =>
              requestInterceptor(
            options,
            isRequireAuth,
            requestInterceptorHandler,
          ),
          onResponse: (
            Response response,
            ResponseInterceptorHandler responseInterceptorHandler,
          ) =>
              responseInterceptor(
            response,
            responseInterceptorHandler,
          ),
          onError: (
            DioError dioError,
            ErrorInterceptorHandler errorInterceptorHandler,
          ) =>
              errorInterceptor(dioError, dio, errorInterceptorHandler),
        ),
      )
      ..transformer = FlutterTransformer();
  }

  static Dio addInterceptorsMultipart({
    required Dio dio,
    bool isRequireAuth = true,
  }) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (
            RequestOptions options,
            RequestInterceptorHandler requestInterceptorHandler,
          ) =>
              requestInterceptorMultipart(
            options,
            isRequireAuth,
            requestInterceptorHandler,
          ),
          onResponse: (
            Response response,
            ResponseInterceptorHandler responseInterceptorHandler,
          ) =>
              responseInterceptor(
            response,
            responseInterceptorHandler,
          ),
          onError: (
            DioError dioError,
            ErrorInterceptorHandler errorInterceptorHandler,
          ) =>
              errorInterceptor(
            dioError,
            dio,
            errorInterceptorHandler,
          ),
        ),
      )
      ..transformer = FlutterTransformer();
  }

  static dynamic responseInterceptor(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    var baseResponse = response.data;
    handler.next(
      Response(
        data: baseResponse,
        headers: response.headers,
        requestOptions: response.requestOptions,
        isRedirect: response.isRedirect,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response.extra,
      ),
    );
  }

  static requestInterceptor(
    RequestOptions options,
    bool isRequireAuth,
    RequestInterceptorHandler handler,
  ) async {
    options.responseType = ResponseType.json;
    String? token;
    if (isRequireAuth) {
      String userToken = PreferenceUtils().getUserToken() ?? '';
      token = userToken;
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  static dynamic errorInterceptor(
    DioError dioError,
    Dio dio,
    ErrorInterceptorHandler handler,
  ) {
    var message = dioError.message;
    var isServerError = false;
    var errorMsg = '';

    try {
      if (dioError.response != null) {
        var errMdl = dioError.response!.data;
        if (errMdl['message'] != null) {
          errorMsg = errMdl['message'];
        }
        if (dioError.response!.statusCode == 401) {
          //TODO REFRESH TOKEN HERE
        } else if (dioError.response!.statusCode == 422) {
          LogUtil().loggingTest('error 422: $message');
        } else if (dioError.response!.statusCode == 402) {
          message = dioError.response!.statusCode.toString();
        } else if (dioError.response!.statusCode == 400) {
        } else {
          if (errMdl is! String) {
            message = errorMsg;
          } else {
            message =
                'Koneksi server error, coba lagi nanti ["${dioError.response!.statusCode}"]';
            isServerError = true;
          }
        }
      } else {
        if (dioError.message.toLowerCase().contains('failed host lookup') ||
            dioError.message.toLowerCase().contains('connection refused')) {
          message = 'Tidak ada koneksi internet';
        } else {
          try {
            message =
                'Koneksi server error, coba lagi nanti ["${dioError.response!.statusCode}"]';
            isServerError = true;
          } catch (_) {
            message =
                'Tidak dapat menyambungkan ke server, coba lagi nanti ["${dioError.response!.statusCode}"]';
          }
        }
      }
    } catch (e) {
      try {
        message =
            'Koneksi server error, coba lagi nanti ["${dioError.response!.statusCode}"]';
        isServerError = true;
      } catch (e) {
        message =
            'Koneksi server error, coba lagi nanti ["${dioError.response!.statusCode}"]';
        isServerError = true;
      }
    }
    if (isServerError) {
      if (dioError.response!.statusCode == 503) {
        //TODO GO TO MAINTENANCE PAGE
      }
    }
    dioError.error = message;

    return handler.next(dioError);
  }

  Future<bool> clearAllCache() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result != ConnectivityResult.none) {
      await _dioCacheManager!.clearAll();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> clearCache(String primaryKey, String requestMethod,
      {String? subKey}) async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result != ConnectivityResult.none) {
      await _dioCacheManager!.delete(
        primaryKey,
        requestMethod: requestMethod,
        subKey: subKey,
      );
      await _dioCacheManager!.delete(
        'ADD KEY HERE',
        requestMethod: 'GET',
      );
      await _dioCacheManager!.delete('ADD KEY HERE', requestMethod: 'GET');

      return true;
    } else {
      return false;
    }
  }
}

class FlutterTransformer extends DefaultTransformer {
  FlutterTransformer() : super(jsonDecodeCallback: _parseJson);
}

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}
