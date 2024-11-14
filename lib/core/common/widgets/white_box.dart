import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget whiteBox({
  required String text,
  required VoidCallback onTap,
  String? type,
}) {
  return Positioned(
    left: type == 'otp' ? 51.w : 48.w,
    right: type == 'otp' ? 51.w : 48.w,
    //top: 550.h,
    bottom: type == 'otp' ? 220.h : 164.h,
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
