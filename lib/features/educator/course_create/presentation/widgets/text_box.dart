import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.controller,
    this.cHeight = 12,
    this.cWidth = 1.5,
    this.contentColor = Colors.white,
    required this.hintText,
    required this.hintTextStyle,
    required this.borderRadius,
    required this.fillColor,
  });

  final TextEditingController controller;
  final double? cHeight;
  final double? cWidth;
  final Color? contentColor;
  final String hintText;
  final TextStyle hintTextStyle;
  final double borderRadius;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
    );
    return TextFormField(
      controller: controller,
      cursorHeight: cHeight,
      cursorWidth: cWidth!,
      style: TextStyle(color: contentColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintTextStyle,
        contentPadding: const EdgeInsets.only(left: 10),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        focusedErrorBorder: border,
        errorBorder: border,
        isDense: true,
        filled: true,
        fillColor: fillColor,
      ),
      validator: (value) => value!.isEmpty ? 'required' : null,
    );
  }
}
