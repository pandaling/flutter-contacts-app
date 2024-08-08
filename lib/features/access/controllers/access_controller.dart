import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/access/controllers/access_storage.dart';
import 'package:flutter_contacts_app/features/contact/controllers/contact_controller.dart';
import 'package:flutter_contacts_app/features/contact/models/contact_model.dart';

class AccessController extends ChangeNotifier {
  AccessController._();
  static final AccessController instance = AccessController._();
  factory AccessController() => instance;

  Contact? _loginContact;

  final AccessLocalStorage _localStorage = AccessLocalStorage();

  /// Indicator whether the user is logged in or out
  bool get isLoggedIn => _loginContact != null;

  /// Get the login user info
  Contact? get loginUser => _loginContact;

  String? get userId => _loginContact?.id;

  Future<bool> login(String userId) async {
    List<Contact> contacts = await ContactController.instance.loadData();

    if (contacts.isEmpty) {
      return false;
    }

    int index = contacts.indexWhere((contact) => contact.id == userId);

    if (index > -1) {
      await _localStorage.saveLoginInfo(contacts[index]);
      _loginContact = contacts[index];
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    await _localStorage.clearContacts();
  }

  Future<void> loadData() async {
    _loginContact = await _localStorage.loadLoginInfo();
    notifyListeners();
  }
}
