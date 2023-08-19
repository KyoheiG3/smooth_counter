import 'package:intl/intl.dart';

class Formatter {
  late final _formatter = NumberFormat();

  String format(num number, {bool isSeparated = true}) {
    return isSeparated ? _formatter.format(number) : number.toString();
  }

  num parse(String text) => _formatter.parse(text);
}
