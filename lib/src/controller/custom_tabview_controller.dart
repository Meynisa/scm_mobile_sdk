import 'package:core/core.dart';
import '../../../main_lib.dart';

class CustomTabviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int? itemCount = 1;
  Widget? stub;
  ValueChanged<double>? onScroll;
  int? initPosition = 0;
  bool roundedContainer = false;
  bool roundedIndicator = false;
  Color activeColor = Colors.black;
  Color? inactiveColor = ColorsCollection.cInActive;
  List<TicketType>? menuBar;

  TabController? tabcontroller;
  int? _currentCount = 1;
  int? _currentPosition = 0;

  List<TicketType> menuTickets = <TicketType>[
    TicketType.open,
    TicketType.progress,
    TicketType.closed,
    TicketType.pending,
    TicketType.escalated,
    TicketType.spam
  ];

  MainTabbarController? mainController;

  @override
  void onInit() {
    itemCount = menuTickets.length;
    menuBar = menuTickets;
    _currentPosition = initPosition ?? 0;
    tabcontroller = TabController(
        length: itemCount!, vsync: this, initialIndex: _currentPosition!);
    tabcontroller!.addListener(_onPositionChange);
    tabcontroller!.animation!.addListener(_onScroll);
    _currentCount = itemCount;
    super.onInit();
  }

  @override
  void onReady() {
    if (_currentCount != itemCount) {
      tabcontroller!.animation!.removeListener(_onScroll);
      tabcontroller!.removeListener(_onPositionChange);
      tabcontroller!.dispose();

      if (initPosition != null) {
        _currentPosition = initPosition;
      }

      tabcontroller = TabController(
          length: itemCount!, vsync: this, initialIndex: _currentPosition!);
      tabcontroller!.addListener(_onPositionChange);
      tabcontroller!.animation!.addListener(_onScroll);

      _currentCount = itemCount;
    } else if (initPosition != null) {
      tabcontroller!
          .animateTo(initPosition!, duration: const Duration(seconds: 0));
    }
    update();
    super.onReady();
  }

  @override
  void dispose() {
    tabcontroller!.animation!.removeListener(_onScroll);
    tabcontroller!.removeListener(_onPositionChange);
    tabcontroller!.dispose();
    super.dispose();
  }

  _onPositionChange() {
    if (!tabcontroller!.indexIsChanging) {
      _currentPosition = tabcontroller!.index;
      tabcontroller!.animateTo(tabcontroller!.index,
          duration: const Duration(seconds: 0));
      mainController = MainTabbarController();
      mainController!.handlePageIndex(_currentPosition!);
    }
  }

  jumpToPosition(int position) {
    if (position != _currentPosition) {
      _currentPosition = position;
      tabcontroller!.animateTo(position, duration: const Duration(seconds: 0));
      mainController = MainTabbarController();
      mainController!.handlePageIndex(_currentPosition!);
    }
  }

  _onScroll() {
    if (onScroll is ValueChanged<double>) {
      onScroll!(tabcontroller!.animation!.value);
    }
  }
}
