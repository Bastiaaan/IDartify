
import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  DateTime sqlNow() {
    var format = DateFormat('yyyy-mm-dd hh:mm:ss');
    return format.parse(this.toString());
  }
}
  
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
}