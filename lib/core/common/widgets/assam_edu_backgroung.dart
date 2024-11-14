import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget assamEduBackgroung() {
  return Positioned.fill(
    right: 30.w,
    child: FittedBox(
      fit: BoxFit.fill,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          'ASSAM\nEDU',
          style: TextStyle(
            fontSize: 100.sp,
            color: const Color.fromRGBO(141, 191, 188, 1.0),
            fontWeight: FontWeight.bold,
            height: 0.7.sp, // Adjust this value to reduce the gap
          ),
          textAlign: TextAlign.start,
        ),
      ),
    ),
  );
}
