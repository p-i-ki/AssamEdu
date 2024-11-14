import 'package:flutter/material.dart';

Widget googleAuth({
  required VoidCallback onTap,
  required String text,
}) {
  return Container(
    height: 22,
    padding: const EdgeInsets.only(bottom: 2),
    child: ElevatedButton.icon(
      onPressed: onTap,
      icon: Image.asset('assets/images/icons8-google-48.png', height: 14.0),
      iconAlignment: IconAlignment.end,
      label: Text(
        text,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 6),
      ),
    ),
  );
}
