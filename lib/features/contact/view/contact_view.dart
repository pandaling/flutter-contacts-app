import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/access/controllers/access_controller.dart';
import 'package:flutter_contacts_app/features/contact/controllers/contact_controller.dart';
import 'package:flutter_contacts_app/features/contact/models/contact_model.dart';
import 'package:flutter_contacts_app/features/contact/view/contact_details_view.dart';
import 'package:flutter_contacts_app/styles/app_style.dart';
import 'package:flutter_contacts_app/styles/media.dart';
import 'package:flutter_contacts_app/styles/palette.dart';
import 'package:flutter_contacts_app/widgets/text_field/custom_text_field.dart';
import 'package:provider/provider.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final TextEditingController _searchCtrl = TextEditingController();
  Map<String, List<Contact>> groupedData = {};
  String searchFirstLetter = '';

  groupData(sortedContacts) {
    Map<String, List<Contact>> groupedData = {};

    for (var item in sortedContacts) {
      String firstLetter = item.firstName[0].toUpperCase();
      if (!groupedData.containsKey(firstLetter)) {
        groupedData[firstLetter] = [];
      }
      groupedData[firstLetter]!.add(item);
    }

    return groupedData;
  }

  _onChanged(String value) {
    // NOTE: Do 1 level filtering only
    if (value.isNotEmpty) {
      String firstLetter = value[0].toUpperCase();

      setState(() {
        searchFirstLetter = firstLetter;
      });
    } else {
      // complete set of data
      setState(() {
        searchFirstLetter = '';
      });
    }
  }

  Future<void> _handleRefresh() async {
    await ContactController.instance.refreshData();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Contact> contacts = context.watch<ContactController>().contacts;
    contacts.sort((a, b) => a.firstName.compareTo(b.firstName));

    groupedData = groupData(contacts);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Contacts',
          style: AppStyle.appBarText,
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Column(
                children: [
                  CustomTextField(
                    controller: _searchCtrl,
                    labelText: 'search your contact list...',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    onChanged: _onChanged,
                    suffixIcon: Image.asset(Media.searchActive),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildContactList(groupedData),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.blue,
        elevation: 0,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ContactDetailsView()),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _buildContactList(Map<String, List<Contact>> groupedData) {
    List<Widget> widgets = [];

    groupedData.forEach((alphabet, contactList) {
      if (searchFirstLetter.isNotEmpty && alphabet == searchFirstLetter) {
        _generateContactList(widgets, alphabet, contactList);
      }

      if (searchFirstLetter.isEmpty) {
        _generateContactList(widgets, alphabet, contactList);
      }
    });

    return widgets;
  }

  _generateContactList(List<Widget> widgets, String alphabet, List<Contact> contactList) {
    widgets.add(
      Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Text(
          alphabet,
          style: AppStyle.alphabetText,
        ),
      ),
    );

    widgets.add(
      const Divider(
        color: Palette.darkGrey,
      ),
    );

    widgets.addAll(
      contactList.map(
        (contact) => ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ContactDetailsView(contact: contact)),
          ),
          contentPadding: const EdgeInsets.only(bottom: 12.0),
          leading: CircleAvatar(
            backgroundColor: Palette.blue,
            radius: 23.5,
            child: Text(
              '${contact.firstName[0].toUpperCase()}${contact.lastName[0].toUpperCase()}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                color: Palette.white,
              ),
            ),
          ),
          title: Row(
            children: [
              Text('${contact.firstName} ${contact.lastName}'),
              AccessController.instance.userId == contact.id
                  ? Text(
                      ' (you)',
                      style: AppStyle.placeholderText.copyWith(fontStyle: FontStyle.italic),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );

    return widgets;
  }
}
