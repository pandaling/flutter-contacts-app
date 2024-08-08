import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/styles/palette.dart';

class AppStyle {
  static const TextStyle placeholderText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: Palette.placeholder,
  );

  static const TextStyle textFieldLabel = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Palette.black,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w900,
    color: Palette.blue,
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: Palette.red,
  );

  static const TextStyle appBarText = TextStyle(
    fontSize: 23.0,
    fontWeight: FontWeight.w700,
    color: Palette.black,
  );

  static const TextStyle alphabetText = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w700,
    color: Palette.blue,
  );
}
