import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class UserProfilePhoto extends StatelessWidget {
  final String image;
  const UserProfilePhoto({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 40.h,
      decoration: BoxDecoration(
        color: HexColor('E9EBFD'),
        border:
            Border.all(width: 5, color: HexColor('66300E').withOpacity(0.6)),
        borderRadius: BorderRadius.circular(70),
      ),
      child: ClipOval(
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
