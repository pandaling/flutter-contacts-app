import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/styles/app_style.dart';
import 'package:flutter_contacts_app/styles/palette.dart';

abstract class RoundedRectangleButtonView extends StatelessWidget {
  const RoundedRectangleButtonView({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.padding = const EdgeInsets.symmetric(vertical: 11.0, horizontal: 35.0),
    this.buttonBgColor = Palette.blue,
    this.side,
    this.textStyle = AppStyle.buttonText,
  })  : assert(height == null || height >= 0, '"height" cannot be a negative value.'),
        assert(width == null || width >= 0, '"width" cannot be a negative value.');

  /// Text label for the button
  final String label;

  /// OnPressed function for the button.
  final void Function() onPressed;

  /// The [height] if the widget built.
  final double? height;

  /// The [width] if the widget built.
  final double? width;

  /// To adjust the border radius.
  final BorderRadiusGeometry borderRadius;

  /// To adjust the padding.
  final EdgeInsetsGeometry padding;

  /// Set the background color of the button.
  final Color buttonBgColor;

  final BorderSide? side;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final ElevatedButton buttonLayout = ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: side != null ? const BorderSide(color: Palette.red) : BorderSide.none,
          ),
        ),
        padding: WidgetStateProperty.all(padding),
        backgroundColor: WidgetStateProperty.all<Color>(
          buttonBgColor.withOpacity(0.1),
        ),
        shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
      ),
      child: Text(
        label,
        style: textStyle,
      ),
    );

    Widget layout = buttonLayout;

    if (height != null || width != null) {
      layout = SizedBox(
        width: width,
        height: height,
        child: buttonLayout,
      );
    }

    return layout;
  }
}

class RoundedRectangleButton extends RoundedRectangleButtonView {
  const RoundedRectangleButton({
    super.key,
    required super.label,
    required super.onPressed,
    super.padding,
  });

  const RoundedRectangleButton.danger({
    super.key,
    required super.label,
    required super.onPressed,
    super.padding,
    super.textStyle = AppStyle.errorText,
    super.side = const BorderSide(color: Palette.red),
    super.buttonBgColor = Palette.white,
  });
}
