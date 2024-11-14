import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget backGroundScreen() {
  print("backGroundScreen is Executed");
  return Positioned.fill(
    child: Container(
      color: const Color.fromRGBO(254, 245, 233, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
      alignment: Alignment.topLeft,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          'ASSAM\nEDU.',
          style: TextStyle(
            fontSize: 130.sp,
            color: const Color.fromRGBO(2, 124, 133, 1.0),
            fontWeight: FontWeight.bold,
            height: 0.7.sp, // Adjust this value to reduce the gap
          ),
          textAlign: TextAlign.start,
        ),
      ),
    ),
  );
}

Widget bookLogo() {
  print("bookLogo is Executed");
  return Positioned(
    width: 225.w,
    height: 300.h,
    left: 120.w,
    right: null,
    top: null,
    bottom: 400.h,
    child: Image.asset(
      'assets/images/logo.png',
    ),
  );
}

Widget motivationText() {
  print("motivationText is Executed");
  return Positioned(
    width: 200.w,
    left: 220.w,
    right: null,
    top: null,
    bottom: 400.h,
    child: Text(
      'Empowering Minds,\nEnriching Futures.',
      style: TextStyle(fontSize: 13.sp),
    ),
  );
}

Widget navigationTextButton({
  required BuildContext context,
  required String buttonTextLeft,
  required String buttonTextRight,
  required void Function()? onPressedLeft,
  required void Function()? onPressedRight,
}) {
  print("navigationTextButton is Executed");
  return Positioned(
    left: 55.w,
    right: 55.w,
    top: 445.h,
    bottom: 150.h,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.w)),
      color: const Color.fromRGBO(255, 248, 239, 1.0),
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: onPressedLeft,
              child: Text(
                buttonTextLeft,
                style: TextStyle(
                  height: 4.h,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: onPressedRight,
              child: Text(
                buttonTextRight,
                style: TextStyle(
                  height: 4.h,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget mainText({required String text}) {
  print("mainText is Executed");
  return Positioned(
    left: 55.w,
    right: 55.w,
    top: 405.h,
    bottom: 190.h,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.w)),
      color: const Color.fromRGBO(85, 92, 170, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 20.sp,
                height: 2.h,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
              height: 50.h,
              width: 44.w,
              color: const Color.fromRGBO(198, 205, 234, 1.0),
            ),
          ],
        ),
      ),
    ),
  );
}
