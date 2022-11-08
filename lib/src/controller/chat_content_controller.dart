import 'package:core/core.dart';
import '../../../main_lib.dart';

class ChatContentController extends GetxController with StateMixin {
  Rx<TicketType> ticketType = TicketType.open.obs;
  final ChatRepository _chatRepository = ChatRepositoryImpl();

  final SocketController socketController = Get.find<SocketController>();
  final CustomTabviewController controller =
      Get.find<CustomTabviewController>();
  MeData? _meData;

  @override
  void onInit() {
    fetchStreamMessage();
    super.onInit();
  }

  fetchStreamMessage() async {
    change(null, status: RxStatus.loading());
    socketController.newUpdateMsg.value = 0;
    try {
      _meData = MeData.fromJson(
          PreferenceUtils().getFromPreferences(StringPreferences.meSetting) ??
              MeData().toJson());

      StreamParam streamParam = StreamParam.fromJson(
          PreferenceUtils().getFromPreferences(StringPreferences.userFilter) ??
              StreamParam().toMap());
      streamParam.section = ticketType.value.name.toLowerCase();

      StreamsResponse result =
          await _chatRepository.fetchStreamMessage(streamParam);
      socketController.listAllTickets[ticketType.value.index] = result.rows!;
      var items = socketController.listAllTickets[ticketType.value.index];
      change(items, status: RxStatus.success());
    } on DioError catch (error) {
      change(error.message, status: RxStatus.error());
      if (error.response!.statusCode == 401) {
        AlertDialogCustom().alertDialog(
            Get.context!,
            DictionaryUtil.attention.tr,
            'Your session has ended. Please try to login again',
            isOneButton: true,
            isDismissable: false,
            onPressedOK: () => _logoutEvent());
      }
      printError(info: 'Error fetching stream message : ${error.message}');
    }
  }

  getTickets() {
    var items = socketController.listAllTickets[ticketType.value.index];
    change(items, status: RxStatus.success());
  }

  void newUpdatesOnTapped() {
    ticketType.value = TicketType.open;
    socketController.ticketType.value = TicketType.open;
    controller.jumpToPosition(0);
    fetchStreamMessage();
  }

  void onTapNextPage({StreamRows? item}) {
    (item!.lock != null && item.lock!.user != _meData!.id)
        ? AlertDialogCustom().alertDialog(
            Get.context!,
            'You can\'t open the ticket',
            'Ticket are being opened by ${item.lock!.name ?? ''}',
            isOneButton: true,
            onPressedOK: () => Get.back())
        : (item.assignTo != null && item.assignTo!.id != _meData!.id)
            ? AlertDialogCustom().alertDialog(
                Get.context!,
                'You can\'t open the ticket',
                'This ticket can only be handled by ${item.assignTo!.name ?? ''}',
                isOneButton: true,
                onPressedOK: () => Get.back())
            : Get.toNamed(AppPages.CHAT_ROOM,
                arguments: item.toJson(),
                parameters: {'ticket_type': ticketType.value.name});
  }

  void _logoutEvent() {
    socketController.disconnectingSocket();
    AlertDialogCustom().loading();
    PreferenceUtils().clearAllData();
    Get.back();
    Get.offNamedUntil(AppPages.LOGIN, (route) => false);
  }
}
