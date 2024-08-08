import 'package:flutter_contacts_app/features/contact/models/contact_model.dart';
import 'package:flutter_contacts_app/utils/file_loader.dart';
import 'package:flutter_contacts_app/utils/local_storage.dart';

class ContactLocalStorage extends LocalStorage {
  ContactLocalStorage() : super('contact');

  Future<void> saveContact(List<Contact> contacts) async {
    final List<Map<String, dynamic>> json = contacts.map((contact) => contact.toJson()).toList();

    await save(json);
  }

  Future<List<Contact>> loadContacts() async {
    List data = await load();

    if (data.isEmpty) {
      data = await FileLoader.from('assets/data.json');
    }

    return data.map((json) => Contact.fromJson(json)).toList();
  }

  Future<List<Contact>> refreshContacts() async {
    List data = await FileLoader.from('assets/data.json');
    return data.map((json) => Contact.fromJson(json)).toList();
  }

  Future<void> clearContacts() async {
    await clear();
  }
}
