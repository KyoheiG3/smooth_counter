import 'package:intl/intl.dart';

class Formatter {
  late final formatter = NumberFormat();

  String format(num number, {bool isSeparated = true}) {
    return isSeparated ? formatter.format(number) : number.toString();
  }

  num parse(String text) => formatter.parse(text);
}
