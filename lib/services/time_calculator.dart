import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeCalculator {
  static String dateTimeToString(DateTime dateTime) {
    String formattedDate = DateFormat.yMd().format(dateTime);

    return formattedDate;
  }

  static Timestamp dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch);
  }

  static DateTime dateTimeFromTimestamp(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  }
}
