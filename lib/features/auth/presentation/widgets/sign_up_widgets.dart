import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget reusableText(String text, {double? fontSize = 13}) {
  return Padding(
    padding: EdgeInsets.only(left: 10.0.w),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize!.sp,
      ),
    ),
  );
}

Widget buildTextField(
    String hintText, String textType, TextEditingController controller) {
  return Container(
    height: 32.h,
    width: 240.w,
    decoration: BoxDecoration(
        border: Border.all(width: 0.0),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w)),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 8.w),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontSize: 16.sp,
      ),
      autocorrect: false,
      obscureText: textType == 'password' ? true : false,
      validator: (value) {
        if (textType == "email") {
          if (value!.isEmpty) {
            return "$hintText is empty!";
          }
          final bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value);
          if (emailValid != true) {
            return "$hintText is Invalid!";
          }
          return null;
        } else {
          if (value!.isEmpty) {
            return "$hintText is empty!";
          }
          final bool passwordValid = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
              .hasMatch(value);
          if (passwordValid != true) {
            return "$hintText is Too Weak(example- As1*4mEd@U)!";
          }
          return null;
        }
      },
    ),
  );
}
