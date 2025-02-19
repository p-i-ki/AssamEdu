import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/features/student/domain/entity/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//const String BASE_IMAGE_URL = "${AppConstants.SERVER_API_URL}/uploads/images/";
Widget courseGrid({required CourseItem course}) {
  //String thumbnailUrl = course.thumbnailUrl ?? ""; // Handle null
  // String fileName = extractFileName(thumbnailUrl); // Extract filename
  return Container(
    decoration: BoxDecoration(
      color: Colors.redAccent.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(8.w),
      image: DecorationImage(
        //image: NetworkImage(course.thumbnailUrl!),
        image: course.thumbnailUrl!.isNotEmpty // Check for null
            ? NetworkImage(
                '${AppConstants.SERVER_API_URL}/${course.thumbnailUrl}',
              )
            : const AssetImage(
                "assets/images/python_course.jpg"), // Provide a default
        fit: BoxFit
            .fitWidth, // Use BoxFit.cover or BoxFit.fitWidth for better scaling
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
