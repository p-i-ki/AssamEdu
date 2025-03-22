import 'package:flutter/material.dart';

class CstmTextFormField extends StatelessWidget {
  const CstmTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.cursorHeight = 12,
    required this.fillColor,
    required this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final double cursorHeight;
  final Color fillColor;
  final String? Function(String? val)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        cursorHeight: cursorHeight,
        cursorWidth: 1.5,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
            contentPadding: const EdgeInsets.only(left: 10),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            errorStyle: const TextStyle(
              fontSize: 10,
              height: 0.8, // Reduces space for error text
              color: Colors.white, // Error text appears inside the field
            ),
            isDense: true,
            filled: true,
            fillColor: fillColor),
        validator: validator);
  }
}

// make this
// then add api for add section and add video..
// then add google auth
// resend otp
// forget password
// paymeny gateway..
