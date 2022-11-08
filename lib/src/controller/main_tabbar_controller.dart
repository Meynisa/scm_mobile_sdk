import 'package:core/core.dart';
import '../../../main_lib.dart';

class MainTabbarController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  MeData? meData;

  final AnalyticsService _analyticsService = AnalyticsService();

  List<Menu> menuAppBar = <Menu>[
    Menu.logout,
  ];

  final ChatContentController chatContentController =
      Get.find<ChatContentController>();

  final SocketController _socketController = Get.find<SocketController>();
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  void onInit() {
    _socketController.connectingSocket();
    categoryController.categoryType == CategoryType.category
        ? categoryController.fetchMultiCategories()
        : null;
    meData = MeData.fromJson(
        PreferenceUtils().getFromPreferences(StringPreferences.meSetting) ??
            MeData().toJson());
    super.onInit();
  }

  void handlePageIndex(int index) {
    // _analyticsService.logPickedTabbar(
    //     tabbar: SocketExtender().intTypeToString(index));
    switch (index) {
      case 0:
        chatContentController.ticketType.value = TicketType.open;
        _socketController.ticketType.value = TicketType.open;
        _getTickets(TicketType.open.index);
        return;
      case 1:
        chatContentController.ticketType.value = TicketType.progress;
        _socketController.ticketType.value = TicketType.progress;
        _getTickets(TicketType.progress.index);
        return;
      case 2:
        chatContentController.ticketType.value = TicketType.closed;
        _socketController.ticketType.value = TicketType.closed;
        _getTickets(TicketType.closed.index);
        return;
      case 3:
        chatContentController.ticketType.value = TicketType.pending;
        _socketController.ticketType.value = TicketType.pending;
        _getTickets(TicketType.pending.index);
        return;
      case 4:
        chatContentController.ticketType.value = TicketType.escalated;
        _socketController.ticketType.value = TicketType.escalated;
        _getTickets(TicketType.escalated.index);
        return;
      case 5:
        chatContentController.ticketType.value = TicketType.spam;
        _socketController.ticketType.value = TicketType.spam;
        _getTickets(TicketType.spam.index);
        return;
      default:
        chatContentController.ticketType.value = TicketType.open;
        _socketController.ticketType.value = TicketType.open;
        _getTickets(TicketType.open.index);
        return;
    }
  }

  void _getTickets(int index) {
    chatContentController.socketController.listAllTickets[index].isNotEmpty
        ? chatContentController
                    .socketController.listAllTickets[index].last.id ==
                null
            ? chatContentController.fetchStreamMessage()
            : chatContentController.getTickets()
        : chatContentController.getTickets();
  }
}
