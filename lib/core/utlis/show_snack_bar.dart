import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text,
    {Color color = Colors.black}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
}
