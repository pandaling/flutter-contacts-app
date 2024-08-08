import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/contact/controllers/contact_storage.dart';
import 'package:flutter_contacts_app/features/contact/models/contact_model.dart';

class ContactController extends ChangeNotifier {
  ContactController._();
  static final ContactController instance = ContactController._();
  factory ContactController() => instance;

  List<Contact> _contacts = [];

  final ContactLocalStorage _localStorage = ContactLocalStorage();

  List<Contact> get contacts => _contacts;

  Future<List<Contact>> loadData() async {
    _contacts = await _localStorage.loadContacts();

    notifyListeners();

    return _contacts;
  }

  Future<List<Contact>> refreshData() async {
    _contacts = await _localStorage.refreshContacts();
    await _localStorage.saveContact(_contacts);

    notifyListeners();

    return _contacts;
  }

  createContact(Contact contact) {
    _contacts.add(contact);
    _saveDate();
    notifyListeners();
  }

  updateContact(Contact contact) {
    int index = _contacts.indexWhere((_contact) => _contact.id == contact.id);

    if (index > -1) {
      _contacts[index] = Contact(
        id: contact.id,
        firstName: contact.firstName,
        lastName: contact.lastName,
        email: contact.email,
        dob: contact.dob,
      );

      _saveDate();
    }

    notifyListeners();
  }

  deleteContact(String? id) {
    _contacts.removeWhere((contact) => contact.id == id);
    _saveDate();
    notifyListeners();
  }

  Future<void> _saveDate() async {
    await _localStorage.saveContact(_contacts);
  }
}
