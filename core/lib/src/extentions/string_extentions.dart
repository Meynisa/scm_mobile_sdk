import 'package:html/parser.dart';
import '../../core.dart';

extension StringExtentions on String {
  String get flavorString {
    List<String> paths = this.split(".");
    return paths[paths.length - 1];
  }

  String? orEmpty() {
    return this;
  }

  bool toBool() {
    return this.toLowerCase() == 'true';
  }

  int toIntorNull() {
    return int.tryParse(this)!;
  }

  double toDoubleOrNull() {
    return double.tryParse(this)!;
  }

//PARSE HTML TO STRING

  String parseHtmlString() {
    var document = parse(this);
    String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

//HTML TO STRING FORMATTER
  String formattedHtmlContent() {
    if (this.length != 0) {
      if ((this[0] == "*" && this.substring(this.length - 1) == "*") ||
          (this[0] == "_" && this.substring(this.length - 1) == "_") ||
          (this[0] == "~" && this.substring(this.length - 1) == "~")) {
        return this.substring(1, this.length - 1);
      } else if ((this[0] == "`" &&
          this[1] == "`" &&
          this[2] == "`" &&
          this.substring(this.length - 3) == "```")) {
        return this.substring(3, this.length - 3);
      } else {
        return this;
      }
    } else {
      return this;
    }
  }

  String formattedContentEmail({bool isPrevMsg = false}) {
    if (this.isNotEmpty &&
        this.contains("</div>\n<br><div>\n<div dir=\"ltr\">")) {
      if (isPrevMsg) {
        String start = "</div>\n<br><div>\n<div dir=\"ltr\">";
        final startIndex = this.indexOf(start);
        String finalStr = this.substring(startIndex + start.length);
        return finalStr;
      } else {
        return this
            .substring(0, this.indexOf('</div>\n<br><div>\n<div dir=\"ltr\">'));
      }
    } else {
      return this;
    }
  }

  String dateConverter({String dateFormat = "dd MMM yyyy | HH:mm"}) {
    return TimeUtils().dateFormat(TimeUtils().dateStringToDateTime(this),
        dateFormat: dateFormat);
  }

  String datetimeConverter() {
    int diff = TimeUtils().calculateDiffInDays(
        TimeUtils().dateStringToDateTime(this), DateTime.now());
    String dateFormat = "dd MMM yyyy | HH:mm";

    if (diff == 0) {
      dateFormat = 'HH:mm';
      return TimeUtils().dateFormat(TimeUtils().dateStringToDateTime(this),
          dateFormat: dateFormat);
    } else if (diff == 1) {
      return 'Yesterday';
    } else if (diff < 8) {
      dateFormat = 'EEEE';
      return TimeUtils().dateFormat(TimeUtils().dateStringToDateTime(this),
          dateFormat: dateFormat);
    } else {
      dateFormat = 'yMd';
      return TimeUtils().dateFormat(TimeUtils().dateStringToDateTime(this),
          dateFormat: dateFormat);
    }
  }

  String chatSourceConverter() {
    if (this == 'telegram') {
      return 'assets/icons/ic_telegram.png';
    } else if (this == 'facebook') {
      return 'assets/icons/ic_fb.png';
    } else if (this == 'twitter') {
      return 'assets/icons/ic_twitter.png';
    } else if (this == 'whatsapp') {
      return 'assets/icons/ic_whatsapp.png';
    } else if (this == 'email') {
      return 'assets/icons/ic_gmail.png';
    } else if (this == 'instagram') {
      return 'assets/icons/ic_ig.png';
    } else if (this == 'line') {
      return 'assets/icons/ic_line.png';
    } else if (this == 'google_play') {
      return 'assets/icons/ic_google_play.jpeg';
    } else if (this == 'sms') {
      return 'assets/icons/ic_sms.jpeg';
    } else if (this == 'chat') {
      return 'assets/icons/ic_webchat.jpeg';
    } else if (this == 'youtube') {
      return 'assets/icons/ic_youtube.jpeg';
    } else if (this == 'google_bussiness') {
      return 'assets/icons/ic_google_bussiness.jpeg';
    } else {
      return 'assets/icons/ic_telegram.png';
    }
  }
}

extension DateTimeExtentions on DateTime {
  String datetimeConverter() {
    int diff = TimeUtils().calculateDiffInDays(this, DateTime.now());
    String dateFormat = "dd MMM yyyy | HH:mm";

    if (diff == 0) {
      dateFormat = 'HH:mm';
      return TimeUtils().dateFormat(this, dateFormat: dateFormat);
    } else if (diff == 1) {
      return 'Yesterday';
    } else if (diff < 8) {
      dateFormat = 'EEEE';
      return TimeUtils().dateFormat(this, dateFormat: dateFormat);
    } else {
      dateFormat = 'yMd';
      return TimeUtils().dateFormat(this, dateFormat: dateFormat);
    }
  }

  String dateConverter({String dateFormat = "dd MMM yyyy | HH:mm"}) {
    return TimeUtils().dateFormat(this, dateFormat: dateFormat);
  }
}
