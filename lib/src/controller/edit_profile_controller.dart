import 'package:core/core.dart' as core;
import '../../main_lib.dart';

class EditProfileController extends GetxController {
  final ChatRepository _chatRepository = ChatRepositoryImpl();
  RxBool isLoading = true.obs;
  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    textController.text = Get.arguments['value'];
    super.onInit();
  }

  void postEditProfile() async {
    try {
      String roomId = core.PreferenceUtils()
              .getStringPreferences(core.StringPreferences.roomId) ??
          '';
      core.FormData formData = core.FormData.fromMap({
        Get.arguments['type'].toString().toLowerCase() == 'phone number'
                ? 'phone'
                : Get.arguments['type'].toString().toLowerCase():
            Get.arguments['value'],
        'id': roomId,
        'section':
            Get.arguments['type'].toString().toLowerCase() == 'phone number'
                ? 'phone'
                : Get.arguments['type'].toString().toLowerCase()
      });
      var result = await _chatRepository.editProfile(formData);
      isLoading.value = false;
      core.AlertDialogCustom().alertDialog(Get.context!, 'Success',
          'Your ${Get.arguments['type']} has been successfully updated!\n\nSimilar contact with ${Get.arguments['type']} ${Get.arguments['value']} found. You can merge them!',
          isOneButton: true, onPressedOK: () {
        Get.back();
        Get.back();
      });
    } on core.DioError catch (error) {
      isLoading.value = false;
      printError(info: 'Error post edit profile : ${error.message}');
    }
  }

  void saveChanges() {
    textController.text != ""
        ? postEditProfile()
        : Get.snackbar(
            'Oops...', 'Please fill the ${Get.arguments['type']} correctly',
            backgroundColor: core.ColorsCollection.cBlue,
            colorText: Colors.white,
            animationDuration: const Duration(milliseconds: 400));
  }
}
