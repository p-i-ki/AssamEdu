import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget courseGrid() {
  return Container(
    decoration: BoxDecoration(
      // color: Colors.redAccent,
      borderRadius: BorderRadius.circular(8.w),
      image: const DecorationImage(
          // server only gives us the image(like "images/imageName.jpg") name (as thumbnail) from the database , we have to fetch the image from the database using api call
          // in the backend -> we are keeping the image in the uploads/ folder
          image: AssetImage('assets/images/python_course.jpg'),
          fit: BoxFit.fitHeight),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              "Python for Begineers",
              //if a long string come from backend then it will handle that
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              softWrap: true, //want text into a new line
              style: TextStyle(
                  color: Colors.red,
                  // fontWeight: FontWeight.bold,
                  fontSize: 11.sp),
            ),
          )
        ],
      ),
    ),
  );
}
