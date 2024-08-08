import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/styles/app_style.dart';
import 'package:flutter_contacts_app/styles/palette.dart';

/// This is a custom [TextField] for this application.
/// This widget does not included the title or label for the text field.
///
/// Example of how to use this widget is as below
///
/// ```dart
/// CustomTextField(
///   controller: controller,
/// )
/// ```
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.maxLines = 1,
    this.labelText,
    this.hintText,
    this.labelStyle = AppStyle.placeholderText,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.floatingLabelBehavior,
    this.onChanged,
  });

  final TextEditingController controller;
  final int? maxLines;
  final String? labelText;
  final String? hintText;
  final TextStyle labelStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.darkGrey,
            width: 1.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Palette.darkGrey,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Palette.blue,
            width: 1.0,
          ),
        ),
        labelText: labelText ?? '',
        labelStyle: labelStyle,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        alignLabelWithHint: true,
        floatingLabelBehavior: floatingLabelBehavior,
      ),
    );
  }
}

/// This included [CustomTextField] with a [Text] as a title label for the text field.
class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.tfTitle,
    this.prefixIcon,
    this.suffixIcon,
    this.isCompulsory = false,
    this.labelText,
  });

  final TextEditingController controller;
  final String tfTitle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isCompulsory;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: tfTitle,
                style: AppStyle.textFieldLabel,
              ),
              if (isCompulsory)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Palette.red),
                )
            ],
          ),
        ),
        const SizedBox(height: 6),
        CustomTextField(
          controller: controller,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        )
      ],
    );
  }
}
