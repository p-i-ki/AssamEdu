import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text,
    {Color color = Colors.green, String type = "success"}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: type == "success" ? color : Colors.redAccent,
        duration: const Duration(seconds: 3),
      ),
    );
}
