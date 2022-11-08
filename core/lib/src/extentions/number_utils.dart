import '../../core.dart';

extension IntegerExtensionUtils on int {
  int? orZero() {
    return this;
  }
}

extension DoubleExtensionUtils on double {
  double? orZero() {
    return this;
  }
}

class NumberUtils {
  String formatNumberSeparator(double number) {
    var formatter = NumberFormat('###,###,###,###');
    return formatter.format(number);
  }

  String? numberUtilFormatter(String currentBalance) {
    // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
    double value = double.parse(currentBalance);
    if (value < 1000) {
      // less than a million
      return currentBalance.replaceAll('.', ','); //.toStringAsFixed(2);
    } else if (value >= 1000 && value < 1000000) {
      // less than a million
      double result = value / 1000;
      return result.toStringAsFixed(3).replaceAll('.', ',');
    } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
      // less than 100 million
      double result = value / 1000000;
      return result.toStringAsFixed(3).replaceAll('.', ',') + " M";
    } else if (value >= (1000000 * 10 * 100) &&
        value < (1000000 * 10 * 100 * 100)) {
      // less than 100 billion
      double result = value / (1000000 * 10 * 100);
      return result.toStringAsFixed(3).replaceAll('.', ',') + " B";
    } else if (value >= (1000000 * 10 * 100 * 100) &&
        value < (1000000 * 10 * 100 * 100 * 100)) {
      // less than 100 trillion
      double result = value / (1000000 * 10 * 100 * 100);
      return result.toStringAsFixed(3).replaceAll('.', ',') + " T";
    } else {
      return currentBalance;
    }
  }
}
