import 'package:core/core.dart';
import '../../../main_lib.dart';

class HistoryController extends GetxController with StateMixin {
  final ChatRepository _chatRepository = ChatRepositoryImpl();

  TicketParam? _ticketParam;
  List<PreviousTickets>? listTickets;
  RxInt selectedItem = 0.obs;
  RxList<TicketStreams> listMessage = RxList<TicketStreams>();

  @override
  void onInit() {
    listTickets = Get.arguments['list_tickets'];
    listTickets!.isEmpty ? null : fetchTicketMessage(listTickets![0].id!);
    super.onInit();
  }

  void fetchTicketMessage(String ticketId) async {
    change(null, status: RxStatus.loading());
    try {
      int projectId =
          PreferenceUtils().getFromPreferences(StringPreferences.projectId) ??
              0;

      _ticketParam = TicketParam(ticketId, projectId: projectId);
      TicketResponse result =
          await _chatRepository.fetchTicketMessage(_ticketParam!);
      listMessage.value = result.data!.streams!;
      change(result.data, status: RxStatus.success());
    } on DioError catch (error) {
      String text = error.message;
      change(null, status: RxStatus.error(text));
      printError(info: 'Error fetching ticket message : ${error.message}');
    }
  }
}
