import 'package:core/core.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtil().loggingTest(
        "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + options.path}");

    LogUtil().loggingTest("Headers:");
    options.headers.forEach((k, v) => LogUtil().loggingTest('$k: $v'));

    if (options.queryParameters != null) {
      LogUtil().loggingTest("queryParameters:");
      options.queryParameters
          .forEach((k, v) => LogUtil().loggingTest('$k: $v'));
    }
    if (options.data != null) {
      LogUtil().loggingTest("Body: ${options.data}");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    LogUtil().loggingTest(
        "<-- ${dioError.message} ${(dioError.response!.requestOptions != null ? (dioError.response!.requestOptions.path) : 'URL')}");
    LogUtil().loggingTest(
        "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}");
    LogUtil().loggingTest("<-- End error");
    return super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LogUtil().loggingTest(
        "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.path) : 'URL')}");
    LogUtil().loggingTest("Headers:");
    response.headers.forEach((k, v) => LogUtil().loggingTest('$k: $v'));
    LogUtil().loggingTest("Response: ${response.data}");
    LogUtil().loggingTest("<-- END HTTP");
    return super.onResponse(response, handler);
  }
}
