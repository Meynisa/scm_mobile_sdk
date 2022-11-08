import 'dart:io';
import 'package:core/core.dart';
import '../../../main_lib.dart';

class ChatRoomController extends GetxController with StateMixin {
  final ChatRepository _chatRepository = ChatRepositoryImpl();
  TextEditingController messageController = TextEditingController();
  RxBool isValidMessage = false.obs;
  RxBool isLoading = true.obs;
  RxBool isSent = true.obs;
  bool isTicketAvailable = true;
  String ticketId = '';

  List<MenuRoomCloseType> menuCloseTickets = <MenuRoomCloseType>[
    MenuRoomCloseType.history,
    MenuRoomCloseType.category
  ];

  List<MenuRoom> menuTickets = <MenuRoom>[
    MenuRoom.history,
    MenuRoom.category,
    MenuRoom.close,
  ];

  TicketParam? _ticketParam;
  TicketResponse? _ticketResponse;
  final SocketController socketController = Get.find<SocketController>();
  final CategoryController categoryController = Get.find<CategoryController>();
  final TemplateMessageController _templateMessageController =
      Get.find<TemplateMessageController>();
  Rx<TicketData> ticketData = TicketData().obs;
  int chatId = 0;
  TicketStreams? data;
  RxBool isMaxLine = false.obs;
  int numLines = 0;

  @override
  void onInit() {
    fetchTicketMessage();
    _templateMessageController.fetchTemplateMessage(Get.arguments['source']);
    messageController.addListener(() {
      isValidMessage.value = (messageController.text.isNotEmpty) ? true : false;
      _checkInputHeight();
    });

    super.onInit();
  }

  void _checkInputHeight() async {
    int count = (messageController.text.length * 14) ~/ (Get.size.width - 50);

    count >= 10 ? isMaxLine.value = true : isMaxLine.value = false;
  }

  void fetchTicketMessage() async {
    change(null, status: RxStatus.loading());
    try {
      int projectId =
          PreferenceUtils().getFromPreferences(StringPreferences.projectId) ??
              0;
      ticketId = Get.arguments['id'] ?? '';
      printInfo(info: 'id: $ticketId');
      _ticketParam = TicketParam(ticketId, projectId: projectId);
      TicketResponse result =
          await _chatRepository.fetchTicketMessage(_ticketParam!);
      _ticketResponse = result;
      ticketData.value = result.data!;
      socketController.messages.clear();
      socketController.messages.value = result.data!.streams!;
      PreferenceUtils()
          .saveToPreferences(StringPreferences.roomId, result.data!.id!);
      categoryController.pickedUpTag.value = result.data!.activityCode!;
      categoryController.roomId.value = result.data!.id!;
      isTicketAvailable = true;
      change(result.data, status: RxStatus.success());
    } on DioError catch (error) {
      isTicketAvailable = false;
      String text = error.message;
      if (error.response!.statusCode == 401) {
        text = error.response?.data['message'];
        AlertDialogCustom().alertDialog(
            Get.context!,
            DictionaryUtil.attention.tr,
            'Your session has ended. Please try to login again',
            isOneButton: true,
            isDismissable: false,
            onPressedOK: () => _logoutEvent());
      } else {
        text = error.response?.data['message']['message'];
      }
      change(null, status: RxStatus.error(text));
      printError(info: 'Error fetching ticket message : ${error.message}');
    }
  }

  void _unlockMessage() async {
    try {
      var result = await _chatRepository.unlockMessage(_ticketParam!);
      change(result, status: RxStatus.success());
    } on DioError catch (error) {
      change(error.message, status: RxStatus.error());
      printError(info: 'Error fetching unlock message : ${error.message}');
    }
  }

  void unlockMessage() {
    PreferenceUtils().deleteDataInPreferences(StringPreferences.ticketData);
    _unlockMessage();
    Get.back();
  }

  void replyMessage(
      {bool isResendMsg = false, String? message, File? file}) async {
    chatId = chatId + 1;
    String content = message ?? messageController.text;
    String? fileName, mimeType, mimee;

    if (file != null) {
      fileName = file.path.split('/').last;
      mimeType = mime(fileName);
      mimee = mimeType!.split('/')[0];
    }

    TicketStreams item = TicketStreams(
        user: StreamUser(
            avatar: _ticketResponse!.data!.user!.avatar!,
            hp: _ticketResponse!.data!.user!.hp,
            isWaGroup: _ticketResponse!.data!.user!.isWaGroup ?? false,
            name: _ticketResponse!.data!.user!.name),
        id: _ticketResponse!.data!.id!,
        content: content,
        date: '${DateTime.now()}',
        dateTime: DateTime.now(),
        image: mimee == "image" ? [ImageContent(standard: file!.path)] : null,
        isImage: mimee == "image" ? true : false,
        audio: mimee == "audio" ? AudioContent(url: fileName) : null,
        isAudio: mimee == "audio" ? true : false,
        file: mimee == "application" ? FileContent(url: fileName) : null,
        isFile: mimee == "application" ? true : false,
        video: mimee == "video" ? VideoContent(url: fileName) : null,
        isVideo: mimee == "video" ? true : false,
        source: _ticketResponse!.data!.service,
        attachments: [],
        isSent: true,
        chatId: chatId,
        isOwner: true,
        mimee: mimee);

    socketController.replyMessages(
        isResendMsg ? data! : item, _ticketResponse!.data!.no!);
    messageController.clear();

    try {
      ReplyParam param = ReplyParam(
          _ticketParam!.projectId,
          _ticketResponse!.data!.account!,
          _ticketParam!.ticketId,
          _ticketResponse!.data!.type!,
          content,
          file: file);
      ReplyResponse result = await _chatRepository.replyTickets(param);
    } on DioError catch (error) {
      data = socketController.updateChatStatus(chatId);
      printError(info: 'Error fetching reply message : ${error.message}');
    }
  }

  void closeTicket() async {
    Get.back();
    AlertDialogCustom().loading();
    try {
      String idTicket =
          _ticketResponse == null ? ticketId : _ticketResponse!.data!.id!;
      CloseTicketParam closeTicketParam = CloseTicketParam(idTicket, true);
      var result = await _chatRepository.closeTicket(closeTicketParam);
      Get.back();
      unlockMessage();
    } on DioError catch (error) {
      Get.back();
      printError(info: 'Error close ticket : ${error.message}');
      AlertDialogCustom().alertDialog(Get.context!, 'Error!', error.message,
          isOneButton: true, onPressedOK: () {
        Get.back();
        const CategoryPage().categoryWidget();
      });
    }
  }

  String headerDateConvert(DateTime dateTime) {
    return ((dateTime.day == DateTime.now().day) &&
            (dateTime.month == DateTime.now().month) &&
            (dateTime.year == DateTime.now().year))
        ? 'Today'
        : DateFormat.yMMMMd().format(dateTime);
  }

  sendMessages() {
    isValidMessage.value == true ? replyMessage() : null;
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  profileOnTapped() {
    Get.toNamed(AppPages.DETAIL_PROFILE,
        arguments: _ticketResponse!.data!.toJson());
  }

  void onSelectPopupBtn(value) {
    switch (value) {
      case MenuRoom.history:
        Get.toNamed(AppPages.HISTORY_PAGE, arguments: {
          'list_tickets': _ticketResponse!.data!.previousTickets
        });
        break;
      case MenuRoom.category:
        const CategoryPage().categoryWidget();
        break;
      case MenuRoom.close:
        AlertDialogCustom().alertDialog(Get.context!, 'Are you sure?',
            'Close ticket number #${_ticketResponse != null ? _ticketResponse!.data!.no! : Get.arguments['no']}?',
            leftBtnLabel: 'Cancel',
            rightBtnLabel: 'Yes',
            onPressedOK: () => closeTicket());
        break;
      case MenuRoomCloseType.history:
        Get.toNamed(AppPages.HISTORY_PAGE, arguments: {
          'list_tickets': _ticketResponse!.data!.previousTickets
        });
        break;
      case MenuRoomCloseType.category:
        const CategoryPage().categoryWidget();
        break;
    }
  }

  void _logoutEvent() {
    socketController.disconnectingSocket();
    AlertDialogCustom().loading();
    PreferenceUtils().clearAllData();
    Get.back();
    Get.offNamedUntil(AppPages.LOGIN, (route) => false);
  }
}
