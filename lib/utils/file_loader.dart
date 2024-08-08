import 'dart:convert';
import 'package:flutter/services.dart';

abstract class FileLoaderInterface {}

class FileLoader implements FileLoaderInterface {
  static Future<List> from(String path) async {
    String contents = await rootBundle.loadString(path);
    List envAsList = json.decode(contents);
    return envAsList;
  }
}
