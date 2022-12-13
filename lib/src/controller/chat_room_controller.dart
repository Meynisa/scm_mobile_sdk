import 'dart:io';
import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class ChatRoomController extends GetxController with StateMixin {
  final ChatRepository _chatRepository = ChatRepositoryImpl();
  TextEditingController messageController = TextEditingController();
  RxBool isValidMessage = false.obs;
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
  Rx<TicketData> ticketData = TicketData().obs;
  int chatId = 0;
  TicketStreams? data;
  RxBool isMaxLine = false.obs;
  int numLines = 0;

  int pageIdx = 1;
  double listLayoutSize = 0;
  double screenSize = 0;
  ScrollController scrollController = ScrollController();
  RxBool isHistory = false.obs;
  RxBool isLoadingHistory = false.obs;

  @override
  void onInit() {
    socketController.messages.clear();
    fetchTicketMessage();
    messageController.addListener(() {
      isValidMessage.value = (messageController.text.isNotEmpty) ? true : false;
      _checkInputHeight();
    });

    screenSize = Get.size.height - 300;

    scrollController.addListener(() {
      printInfo(
          info:
              'SCROLL_POSITIONS: ${scrollController.position}, OUT_OF_RANGE: ${scrollController.position.outOfRange}, offset: ${scrollController.offset}, RANGE: ${scrollController.position.maxScrollExtent}');

      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        printInfo(info: 'REFRESH TO HISTORY');
        if (pageIdx <= ticketData.value.previousTickets!.length) {
          isHistory.value = true;
          fetchTicketMessage(
              idTicket: ticketData
                  .value
                  .previousTickets![
                      ticketData.value.previousTickets!.length - pageIdx]
                  .id);
          pageIdx++;
        }
      }
    });

    super.onInit();
  }

  void _checkInputHeight() async {
    int count = (messageController.text.length * 14) ~/ (Get.size.width - 50);

    count >= 10 ? isMaxLine.value = true : isMaxLine.value = false;
  }

  void fetchTicketMessage({String? idTicket}) async {
    isHistory.value == false
        ? change(null, status: RxStatus.loading())
        : isLoadingHistory.value = true;
    try {
      int projectId =
          PreferenceUtils().getFromPreferences(StringPreferences.projectId) ??
              90;
      ticketId = '6374e3b314df60435a87efbe';
      printInfo(info: 'id: $ticketId');
      _ticketParam = TicketParam(idTicket ?? ticketId, projectId: projectId);
      TicketResponse result =
          await _chatRepository.fetchTicketMessage(_ticketParam!);
      _ticketResponse = result;
      ticketData.value = result.data!;
      // socketController.messages.clear();
      result.data!.streams!
          .map((e) => socketController.messages.value.add(e))
          .toList();

      PreferenceUtils()
          .saveToPreferences(StringPreferences.roomId, result.data!.id!);
      isTicketAvailable = true;

      listLayoutSize = socketController.messages.value.length * 60;

      if (listLayoutSize < screenSize &&
          pageIdx <= ticketData.value.previousTickets!.length) {
        printInfo(info: 'REFRESH TO HISTORY');

        fetchTicketMessage(
            idTicket: ticketData
                .value
                .previousTickets![
                    ticketData.value.previousTickets!.length - pageIdx]
                .id);
        pageIdx++;
        isHistory.value = true;
        isLoadingHistory.value = true;
      }
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
    isLoadingHistory.value = false;
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
    // _unlockMessage();
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

  void _logoutEvent() {
    socketController.disconnectingSocket();
    AlertDialogCustom().loading();
    PreferenceUtils().clearAllData();
    Get.back();
    Get.offNamedUntil(AppPages.LOGIN, (route) => false);
  }
}
