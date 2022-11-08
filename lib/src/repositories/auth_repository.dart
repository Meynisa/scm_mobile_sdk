import '../../main_lib.dart';

abstract class AuthRepository {
  Future login(LoginModel paramLoginMdl);
  Future fetchMeSetting();
  Future logout();
}
