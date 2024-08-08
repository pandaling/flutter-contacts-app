import 'package:uuid/uuid.dart';

String generateShortId() {
  var uuid = const Uuid();

  return uuid.v4();
}
