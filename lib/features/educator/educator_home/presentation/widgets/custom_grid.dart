import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';

Widget cstmGrid({required Course course}) {
  final url = course.thumbnailUrl!.contains('http://10.3.0.253:4000')
      ? course.thumbnailUrl
      : "${AppConstants.SERVER_API_URL}/${course.thumbnailUrl}";
  print('--------- Image URL -------: $url');
  return Container(
    decoration: BoxDecoration(
      color: Colors.redAccent.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(8.w),
      image: DecorationImage(
        image: course.thumbnailUrl!.isNotEmpty // Check for null
            ? NetworkImage(
                '$url',
              )
            : const AssetImage(
                "assets/images/python_course.jpg"), // Provide a default
        fit: BoxFit
            .cover, // Use BoxFit.cover or BoxFit.fitWidth for better scaling
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              course.title!,
              //if a long string come from backend then it will handle that
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              softWrap: true, //want text into a new line
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 15.sp),
            ),
          )
        ],
      ),
    ),
  );
}
