import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

Widget menuView() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Explore",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          children: [
            _reusableMenuText("All", backGroundColor: HexColor('050C9C')),
            _reusableMenuText("Popular",
                textColor: Colors.black, backGroundColor: HexColor('D4D4D4')),
            _reusableMenuText("Newest",
                textColor: Colors.black, backGroundColor: HexColor('D4D4D4')),
            _reusableMenuText("Categories",
                textColor: Colors.black, backGroundColor: HexColor('D4D4D4')),
            _reusableMenuText("BestSellers",
                textColor: Colors.black, backGroundColor: HexColor('D4D4D4')),
          ],
        ),
      ),
    ],
  );
}

Widget _reusableMenuText(String text,
    {Color textColor = Colors.white, Color backGroundColor = Colors.blue}) {
  return Container(
      padding: EdgeInsets.fromLTRB(15.w, 5.w, 15.w, 5.w),
      margin: EdgeInsets.only(left: 8.w),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(7.w),
        border: Border.all(color: backGroundColor),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.normal, fontSize: 11),
      ));
}
