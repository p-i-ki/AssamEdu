import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class UserProfilePhoto extends StatelessWidget {
  final String image;
  final String type;
  const UserProfilePhoto({super.key, required this.image, this.type = "asset"});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
          color: HexColor('E9EBFD'),
          border: Border.all(
              width: 5, color: HexColor('66300E').withValues(alpha: 0.6)),
          borderRadius: BorderRadius.circular(70),
        ),
        child: type == "asset"
            ? ClipOval(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              )
            : ClipOval(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ));
  }
}
