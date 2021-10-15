import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';

class IntlTime {
  String getNow() {
    initializeDateFormatting("ja_JP");

    DateTime datetime = DateTime.parse(DateTime.now().toString()); // StringからDate

    var formatter = new DateFormat('yyyy/MM/dd HH:mm', "ja_JP");
    var formatted = formatter.format(datetime); // DateからString
    return formatted;
  }
}
