import 'package:core/core.dart';
import '../parameters/parameters.dart';

class AuthServices {
  Future<Response<dynamic>> login(LoginModel param) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: false)
        .post(Endpoint.login, data: param.toMap());
  }

  Future<Response<dynamic>> logout() {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .get(Endpoint.logout);
  }

  Future<Response<dynamic>> fetchMe() {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .get(Endpoint.meSettings);
  }

  Future<Response<dynamic>> fetchStreamMessage() {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .get(Endpoint.streams);
  }
}
