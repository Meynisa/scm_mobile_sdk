import 'package:core/core.dart';
import '../../../main_lib.dart';

class TemplateMessageController extends GetxController {
  final ChatRepository _chatRepository = ChatRepositoryImpl();

  RxList<ChannelData>? listTemplate = RxList<ChannelData>();
  RxInt radioDateValue = 0.obs;
  ChatRoomController? _chatRoomController;

  void fetchTemplateMessage(String channel) async {
    int projectId =
        PreferenceUtils().getFromPreferences(StringPreferences.projectId) ?? 0;
    TemplateParam templateParam = TemplateParam(projectId, channel);
    try {
      TemplateResponse result =
          await _chatRepository.fetchTemplateMessage(templateParam);
      listTemplate!.value = result.templateData!.channelData!;
    } on DioError catch (error) {
      printError(info: 'Error fetching tag auto complete : ${error.message}');
    }
  }

  void dismissedBottomSheet() {}

  handleTemplateToogle(newValue, int index) {
    _chatRoomController = Get.find<ChatRoomController>();
    radioDateValue.value = newValue;
    _chatRoomController?.messageController.text =
        listTemplate!.value[index].content!;
    Get.back();
  }
}
