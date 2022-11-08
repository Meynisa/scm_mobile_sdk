import 'package:core/core.dart';
import '../../../main_lib.dart';

class ProfileAgentController extends GetxController {
  final ChatRepository _chatRepository = ChatRepositoryImpl();
  final SocketController _socketController = Get.find<SocketController>();
  final AuthRepository _authRepository = AuthRepositoryImpl();
  MeData? meData;
  List<String> statusAppBar = <String>[
    'available',
    'break',
    'coaching',
    'not available',
    'pray',
    'role play',
    'toilet',
    'training'
  ];
  RxString dataChanges = 'available'.obs;

  @override
  void onInit() {
    meData = MeData.fromJson(
        PreferenceUtils().getFromPreferences(StringPreferences.meSetting) ??
            MeData().toJson());
    dataChanges.value = meData!.status!.capitalizeFirst!;
    super.onInit();
  }

  void editStatusAgent() async {
    AlertDialogCustom().loading();
    try {
      var result = await _chatRepository.statusAgent(dataChanges.value);
      Get.back();
    } on DioError catch (error) {
      printError(info: 'Error submit status agent : ${error.message}');
      AlertDialogCustom()
          .onError(customText: error.message, onPressed: () => Get.back());
    }
  }

  void buttonEvent(String? value) {
    dataChanges.value = value!;
    editStatusAgent();
  }

  void logoutEvent() {
    AlertDialogCustom().alertDialog(
        Get.context!, DictionaryUtil.attention.tr, DictionaryUtil.exit_desc.tr,
        onPressedOK: () => fetchLogout());
  }

  void _logoutEvent() {
    _socketController.disconnectingSocket();
    PreferenceUtils().clearAllData();
    Get.back();
    Get.offNamedUntil(AppPages.LOGIN, (route) => false);
  }

  void fetchLogout() async {
    AlertDialogCustom().loading();
    try {
      await _authRepository.logout();
    } on DioError catch (error) {
      printError(info: 'Failed to logout : $error');
    }
    _logoutEvent();
  }
}
