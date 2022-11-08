import 'dart:io';

import 'package:core/core.dart';

class TimeUtils {
  //TIME UTILS
  String timestampToDateString(DateFormat dateFormat, int timestamp) {
    return dateFormat
        .format(new DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

//CONVERTER STRING TO DATE
  DateTime dateStringToDateTime(String dateString) {
    return DateTime.parse(dateString).toLocal();
  }

  DateTime dateStringToHttpDateTime(String dateString) {
    return HttpDate.parse(dateString).toLocal();
  }

  DateTime dateStringToDateTimeWA(String dateString) {
    return DateFormat('dd MMM yyyy HH:mm:ss').parse(dateString);
  }

//DATE FORMATTER
  String dateFormat(DateTime date, {String dateFormat = "MMM dd, yyyy"}) {
    return DateFormat(dateFormat).format(date);
  }

//CALCULATE DIFFERENTIATE DAYS
  int calculateDiffInDays(DateTime dateTimeBefore, DateTime dateTimeAfter) {
    dateTimeBefore =
        DateTime(dateTimeBefore.year, dateTimeBefore.month, dateTimeBefore.day);
    dateTimeAfter =
        DateTime(dateTimeAfter.year, dateTimeAfter.month, dateTimeAfter.day);
    var diffInDays =
        dateTimeAfter.difference(dateTimeBefore).inDays; //differentiate by days
    return diffInDays;
  }

  int calculateDiffInHours(DateTime dateTimeBefore, DateTime dateTimeAfter) {
    var diffInDays = FlavorConfig.instance!.flavor != Flavor.PRODUCTION
        ? dateTimeAfter.difference(dateTimeBefore).inMinutes
        : dateTimeAfter
            .difference(dateTimeBefore)
            .inHours; //differentiate by seconds
    return diffInDays;
  }

  int calculateDiffInMonth(DateTime dateTime) {
    var diffInDays = ((dateTime.difference(DateTime.now()).inDays.abs()) / 30)
        .floor(); //diffe
    return diffInDays;
  }
}
