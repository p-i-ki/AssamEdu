import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget whiteBox({
  required String text,
  required VoidCallback onTap,
  String? type,
}) {
  return Positioned(
    left: type == 'otp' ? 79.w : 72.w,
    right: type == 'otp' ? 79.w : 72.w,
    bottom: type == 'otp' ? 317.h : 250.h,
    child: SizedBox(
      height: 54.h,
      width: 300.w,
      // decoration: BoxDecoration(),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.w))),
        child: Text(
          text,
          style: TextStyle(height: 4.3.h, color: Colors.black),
        ),
      ),
    ),
  );
}
