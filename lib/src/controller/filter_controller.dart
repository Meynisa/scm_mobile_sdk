import 'package:core/core.dart';
import '../../../main_lib.dart';

class FilterController extends GetxController {
  var radioDateValue = 2.obs;
  var sortRadioValue = 0.obs;

  RxString dateChanges = ''.obs;

  Rx dateRangePicker = DateTimeRange(
          end: DateTime.now(),
          start: DateTime.now().subtract(const Duration(days: 6)))
      .obs;

  List<FilterInfo> rangeFilterInfo = [
    FilterInfo(DictionaryUtil.filter_daily, 0),
    FilterInfo(DictionaryUtil.filter_yesterday, 1),
    FilterInfo(DictionaryUtil.filter_7days, 2),
    FilterInfo(DictionaryUtil.filter_30days, 3),
    FilterInfo(DictionaryUtil.filter_month, 4),
    FilterInfo(DictionaryUtil.filter_custom, 5)
  ];

  RxString searchDropdownValue = "No. Ticket".obs;
  List<String> searchDropdownItems = ['No. Ticket'];

  RxString sortDropdownValue = "Conversation".obs;
  List<String> sortDropdownItems = ['Conversation', 'Ticket'];

  List<FilterInfo> listSortRadioBtn = [
    FilterInfo('Descending', 0),
    FilterInfo('Ascending', 1)
  ];

  TextEditingController searchByController = TextEditingController();

  final ChatContentController _chatContentController =
      Get.find<ChatContentController>();

  void showRangePicker() async {
    final picker = await showDateRangePicker(
        context: Get.context!,
        firstDate: DateTime(1900, 1, 1),
        currentDate: DateTime.now(),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                      primary: ColorsCollection.cLightPurple,
                      onPrimary: ColorsCollection.cPurple,
                      onSurface: ColorsCollection.cPurple),
                  textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(primary: Colors.white))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 343.w, maxHeight: 670.h),
                        child: child)
                  ]));
        });
    if (picker == null) return;
    dateRangePicker.value = picker;
    printInfo(info: "range: ${dateRangePicker.value}");
  }

  String getFrom() {
    if (dateRangePicker.value == null) {
      return '';
    } else {
      return DateFormat('MMM dd').format(dateRangePicker.value.start);
    }
  }

  String getUntil() {
    if (dateRangePicker.value == null) {
      return '';
    } else {
      return DateFormat('MMM dd yyy').format(dateRangePicker.value.end);
    }
  }

  void handleSortRadioValueChanges(newValue) {
    sortRadioValue.value = newValue;
  }

  void handleDateRadioValueChanges(newValue) {
    radioDateValue.value = newValue;
    DateTimeRange? picker = DateTimeRange(
        end: DateTime.now().add(const Duration(hours: 24 * 3)),
        start: DateTime.now());
    if (newValue == 0) {
      picker = DateTimeRange(
          end: DateTime.now().add(const Duration(seconds: 10)),
          start: DateTime.now());
    } else if (newValue == 1) {
      picker = DateTimeRange(
          end: DateTime.now().subtract(const Duration(days: 1)),
          start: DateTime.now().subtract(const Duration(days: 1, seconds: 10)));
    } else if (newValue == 2) {
      picker = DateTimeRange(
          end: DateTime.now(),
          start: DateTime.now().subtract(const Duration(days: 6)));
    } else if (newValue == 3) {
      picker = DateTimeRange(
          end: DateTime.now(),
          start: DateTime.now().subtract(const Duration(days: 29)));
    } else if (newValue == 4) {
      var now = DateTime.now();

      var lastDayDateTime = DateTime(now.year, now.month, 1);
      picker = DateTimeRange(end: now, start: lastDayDateTime);
    } else if (newValue == 5) {
      showRangePicker();
    }
    dateRangePicker.value = picker;
    printInfo(info: 'picker: $picker, value: $newValue');
  }

  void handleApplyFilter() {
    _chatContentController.socketController.listAllTickets.value = [
      [StreamRows()],
      [StreamRows()],
      [StreamRows()],
      [StreamRows()],
      [StreamRows()],
      [StreamRows()]
    ];

    StreamParam streamParam = StreamParam.fromJson(
        PreferenceUtils().getFromPreferences(StringPreferences.userFilter) ??
            StreamParam().toMap());

    streamParam = StreamParam(
        projectId: streamParam.projectId,
        section: _chatContentController.ticketType.value.name.toLowerCase(),
        from: dateRangePicker.value.start,
        to: dateRangePicker.value.end,
        sentiment: streamParam.sentiment,
        channels: streamParam.channels,
        limit: streamParam.limit,
        orderBy:
            sortDropdownValue.value == 'Conversation' ? 'date' : 'ticket.id',
        orderDir: sortRadioValue.value == 0 ? 'desc' : 'asc',
        fromTime: streamParam.fromTime,
        toTime: streamParam.toTime,
        offset: streamParam.offset,
        assign: streamParam.assign,
        searchBy: searchDropdownValue.value == 'No. Ticket' ? 'content' : '',
        q: searchByController.text);

    PreferenceUtils()
        .saveToPreferences(StringPreferences.userFilter, streamParam.toMap());

    _chatContentController.fetchStreamMessage();
    Get.back();
  }

  void searchOnChangedValue(String? newValue) {
    searchDropdownValue.value = newValue!;
  }

  void sortOnChangedValue(String? newValue) {
    sortDropdownValue.value = newValue!;
  }

  void resetFilter() {
    searchByController.clear();
    searchDropdownValue.value = 'No. Ticket';
    sortDropdownValue.value = 'Conversation';
    radioDateValue.value = 0;
    sortRadioValue.value = 0;
  }
}

class FilterInfo {
  final String title;
  final int isActivated;

  FilterInfo(this.title, this.isActivated);
}
