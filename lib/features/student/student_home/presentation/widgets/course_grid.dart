import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/entities/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget courseGrid({required CourseItem course}) {
  final imageUrl = course.thumbnailUrl!.startsWith('http')
      ? course.thumbnailUrl!
          .replaceFirst(RegExp(r'^(?:http|https)://[^/]+'), '')
      : '/${course.thumbnailUrl!}';

  final fullImageUrl = "${AppConstants.SERVER_API_URL}$imageUrl";
  print('--------- Image URL -------: $fullImageUrl');
  return Container(
    decoration: BoxDecoration(
      color: Colors.redAccent.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(8.w),
      image: DecorationImage(
        image: course.thumbnailUrl!.isNotEmpty // Check for null
            ? NetworkImage(
                fullImageUrl,
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
