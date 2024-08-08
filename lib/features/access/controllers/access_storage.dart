import 'package:flutter_contacts_app/features/contact/models/contact_model.dart';
import 'package:flutter_contacts_app/utils/local_storage.dart';

class AccessLocalStorage extends LocalStorage {
  AccessLocalStorage() : super('access');

  Future<void> saveLoginInfo(Contact contact) async {
    final List<Map<String, dynamic>> json = [];
    json.add(contact.toJson());

    await save(json);
  }

  Future<Contact?> loadLoginInfo() async {
    final List<Map<String, dynamic>> data = await load();

    if (data.isEmpty) {
      return null;
    }

    List<Contact> contacts = data.map((json) => Contact.fromJson(json)).toList();
    return contacts.first;
  }

  Future<void> clearContacts() async {
    await clear();
  }
}
