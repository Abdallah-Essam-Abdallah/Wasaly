import 'package:intl/intl.dart';

class DateFormater {
  static String formatPostTime(String date) {
    var postingTime = DateTime.parse(date);
    var formatedPostingTime = DateFormat('d MMMM hh:mma').format(postingTime);
    return formatedPostingTime;
  }
}
