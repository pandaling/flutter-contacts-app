import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/contact/models/contact_model.dart';
import 'package:flutter_contacts_app/styles/media.dart';
import 'package:flutter_contacts_app/styles/palette.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    this.contact,
  });

  final Contact? contact;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Palette.blue,
      radius: 50,
      child: contact != null
          ? Text(
              '${contact?.firstName[0].toUpperCase()}${contact?.lastName[0].toUpperCase()}',
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w300,
                color: Palette.white,
              ),
            )
          : Image.asset(
              Media.profileActive,
              width: 40.0,
              height: 40.0,
              fit: BoxFit.contain,
              color: Palette.white,
            ),
    );
  }
}
