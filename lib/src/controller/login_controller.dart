import 'package:core/core.dart';
import '../../../main_lib.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isValidEmail = false.obs;
  RxBool isValidPassword = false.obs;

  final AuthRepository _authRepository = AuthRepositoryImpl();

  RxBool isSubmit = false.obs;

  final AnalyticsService _analyticsService = AnalyticsService();

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(() {
      isValidEmail.value =
          (GetUtils.isEmail(emailController.text)) ? true : false;
    });

    passwordController.addListener(() {
      isValidPassword.value =
          (passwordController.text.length > 5) ? true : false;
    });
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return DictionaryUtil.email_error.tr;
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return DictionaryUtil.password_error.tr;
    }
    return null;
  }

  Function()? submitOnPressedBtn() {
    return (isValidEmail.value && isValidPassword.value)
        ? () => _loginUser()
        : null;
  }

  void _loginUser() async {
    TextInput.finishAutofillContext(shouldSave: true);
    isSubmit.value = true;

    LoginModel paramLoginMdl =
        LoginModel(emailController.text, passwordController.text);

    try {
      LoginResponse result = await _authRepository.login(paramLoginMdl);

      PreferenceUtils().setUserToken(result.token);

      PreferenceUtils()
          .saveToPreferences(StringPreferences.userEmail, emailController.text);

      var timeFirstOpen = PreferenceUtils()
          .getFromLocalPreferences(StringPreferences.timeFirstOpen);
      if (timeFirstOpen == null) {
        PreferenceUtils().saveToLocalPreferences(
            StringPreferences.timeFirstOpen, DateTime.now().toString());
      }

      _fetchMe();
    } on DioError catch (error) {
      Get.snackbar(DictionaryUtil.failed.tr, error.message,
          backgroundColor: ColorsCollection.cBlue,
          colorText: Colors.white,
          animationDuration: const Duration(milliseconds: 400));
      isSubmit.value = false;
    }
  }

  void _fetchMe() async {
    try {
      MeResponse result = await _authRepository.fetchMeSetting();
      PreferenceUtils().saveToPreferences(
          StringPreferences.projectId, result.data!.projects![0].id ?? 0);
      AccountModel accountModel = AccountModel(result.data!.name!,
          result.data!.level!, result.data!.email!, result.data!.avatar!);

      MeData meData = MeData(
          id: result.data!.id,
          name: result.data!.name,
          status: result.data!.status,
          level: result.data!.level,
          email: result.data!.email,
          avatar: result.data!.avatar,
          type: result.data!.type,
          activityCode: result.data!.activityCode,
          projects: result.data!.projects);
      PreferenceUtils()
          .saveToPreferences(StringPreferences.meSetting, meData.toJson());
      PreferenceUtils().saveToPreferences(
          StringPreferences.userProfile, accountModel.toMap());
      PreferenceUtils().saveToPreferences(
          StringPreferences.clientId, result.data!.clientId ?? 0);

      String channels = '';
      for (var i in meData.projects![0].channels!) {
        channels = i == 'chat' ? channels : "$i,$channels";
      }

      StreamParam streamParam = StreamParam(
          projectId: result.data!.projects![0].id ?? 0,
          section: 'open',
          from: DateTime.now().subtract(const Duration(days: 6)),
          to: DateTime.now(),
          sentiment: '1,-1,0',
          channels: channels,
          limit: 50,
          orderBy: 'date',
          orderDir: 'desc',
          fromTime: '00:00:00',
          toTime: '23:59:59',
          offset: 0,
          assign: '',
          searchBy: 'content');

      PreferenceUtils()
          .saveToPreferences(StringPreferences.userFilter, streamParam.toMap());

      // await _analyticsService.logLogin();

      // await _analyticsService.setUserProperties(
      // userId: result.data!.id.toString(),
      // userName: result.data!.name,
      // email: emailController.text,
      // projectId: result.data!.projects![0].id ?? 0);

      isSubmit.value = false;
      Get.toNamed(AppPages.MAIN_TABBAR);
    } on DioError catch (error) {
      isSubmit.value = false;
      printError(info: 'Error fetching me setting : ${error.message}');
    }
  }
}
