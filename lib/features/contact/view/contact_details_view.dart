import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/contact/controllers/contact_controller.dart';
import 'package:flutter_contacts_app/features/contact/models/contact_model.dart';
import 'package:flutter_contacts_app/styles/app_style.dart';
import 'package:flutter_contacts_app/styles/media.dart';
import 'package:flutter_contacts_app/styles/palette.dart';
import 'package:flutter_contacts_app/utils/datetime_formatter.dart';
import 'package:flutter_contacts_app/utils/utils.dart';
import 'package:flutter_contacts_app/widgets/avatar/custom_circle_avatar.dart';
import 'package:flutter_contacts_app/widgets/button/rounded_rectangle_button.dart';
import 'package:flutter_contacts_app/widgets/text_field/custom_text_field.dart';

class ContactDetailsView extends StatefulWidget {
  const ContactDetailsView({
    super.key,
    this.contact,
  });

  final Contact? contact;

  @override
  State<ContactDetailsView> createState() => _ContactDetailsViewState();
}

class _ContactDetailsViewState extends State<ContactDetailsView> {
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();

  Future<String?> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2030),
      context: context,
    );

    return dobDate(pickedDate);
  }

  _update() {
    if (_firstNameCtrl.text.isEmpty || _lastNameCtrl.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text('First name and last name is required'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    Contact contact = Contact(
      id: widget.contact?.id ?? generateShortId(),
      firstName: _firstNameCtrl.text,
      lastName: _lastNameCtrl.text,
      email: _emailCtrl.text,
      dob: _dobCtrl.text,
    );

    if (widget.contact != null) {
      ContactController.instance.updateContact(contact);
    } else {
      ContactController.instance.createContact(contact);
    }

    Navigator.pop(context);
  }

  _remove() {
    ContactController.instance.deleteContact(widget.contact?.id);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    _firstNameCtrl.text = widget.contact?.firstName ?? '';
    _lastNameCtrl.text = widget.contact?.lastName ?? '';
    _emailCtrl.text = widget.contact?.email ?? '';
    _dobCtrl.text = widget.contact?.dob ?? '';
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _dobCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Details',
          style: AppStyle.appBarText,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12.0),
              Align(
                alignment: Alignment.center,
                child: CustomCircleAvatar(contact: widget.contact),
              ),
              const SizedBox(height: 24),
              Text(
                'More Information',
                style: AppStyle.alphabetText.copyWith(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Divider(
                color: Palette.darkGrey,
              ),
              CustomTextFieldWidget(
                controller: _firstNameCtrl,
                tfTitle: 'First Name',
                labelText: 'Enter first name..',
                prefixIcon: Image.asset(
                  Media.profileActive,
                  width: 14.0,
                ),
              ),
              const SizedBox(height: 12),
              CustomTextFieldWidget(
                controller: _lastNameCtrl,
                tfTitle: 'Last Name',
                labelText: 'Enter last name..',
                prefixIcon: Image.asset(
                  Media.profileActive,
                  width: 14.0,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Sub Information',
                style: AppStyle.alphabetText.copyWith(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Divider(
                color: Palette.darkGrey,
              ),
              CustomTextFieldWidget(
                controller: _emailCtrl,
                tfTitle: 'Email Name',
                labelText: 'Enter email..',
                prefixIcon: const Icon(
                  Icons.mail_outline_outlined,
                  color: Palette.blue,
                ),
              ),
              const SizedBox(height: 12),
              CustomTextFieldWidget(
                controller: _dobCtrl,
                tfTitle: 'Date of Birth',
                labelText: 'Enter birthday..',
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_month_rounded,
                    color: Palette.blue,
                  ),
                  onPressed: () async {
                    String? date = await selectDate();
                    _dobCtrl.text = date ?? '';
                  },
                ),
              ),
              const SizedBox(height: 32.0),
              RoundedRectangleButton(
                onPressed: () => _update(),
                label: widget.contact != null ? 'Update' : 'Save',
              ),
              const SizedBox(height: 12.0),
              widget.contact != null
                  ? RoundedRectangleButton.danger(
                      onPressed: () => _remove(),
                      label: 'Remove',
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
