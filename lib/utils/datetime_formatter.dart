import 'package:intl/intl.dart';

String? dobDate(DateTime? date) {
  if (date != null && date != DateTime.now()) {
    return DateFormat('yMd').format(date);
  }

  return null;
}
