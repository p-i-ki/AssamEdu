import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle appStyle(
    {required double size,
    required Color color,
    required FontWeight fontWeight}) {
  return TextStyle(
    fontSize: size.sp,
    color: color,
    fontWeight: fontWeight,
  );
}
