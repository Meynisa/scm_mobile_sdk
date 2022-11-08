import '../../main_lib.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthServices _authServices = AuthServices();
  @override
  Future login(LoginModel paramLoginMdl) async {
    var response = await _authServices.login(paramLoginMdl);
    if (response.data != null) {
      var res = response.data;
      res = LoginResponse.fromJson(res);
      return res;
    } else {
      return throw Exception('failed to login');
    }
  }

  @override
  Future fetchMeSetting() async {
    var response = await _authServices.fetchMe();
    if (response.data != null) {
      var res = response.data;
      res = MeResponse.fromJson(res);
      return res;
    } else {
      return throw Exception('failed to fetch me setting');
    }
  }

  @override
  Future logout() async {
    var response = await _authServices.logout();
    if (response.data != null) {
      var res = response.data;
      return res;
    } else {
      return throw Exception('failed to logout');
    }
  }
}
