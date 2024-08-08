import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final String key;

  LocalStorage(this.key);

  Future<void> saveString<T>(T item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String json = jsonEncode(item);
    await prefs.setString(key, json);
  }

  Future<void> save<T>(List<T> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String json = jsonEncode(data);
    await prefs.setString(key, json);
  }

  Future<List<T>> load<T>() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? json = prefs.getString(key);

    if (json == null) {
      return [];
    }

    return List<T>.from(jsonDecode(json));
  }

  Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
