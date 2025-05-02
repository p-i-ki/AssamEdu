import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';
import 'package:assam_edu/features/educator/educator_home/presentation/widgets/custom_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routes/names.dart';

class CstmGridView extends StatelessWidget {
  final List<Course> courses;
  const CstmGridView({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 6.w, // Spacing between columns
        mainAxisSpacing: 6.w, // Spacing between rows
        childAspectRatio: 1.4, // Aspect ratio of each grid item
      ),
      itemCount: courses.length, // Number of items to display
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigate to Course Detail Page
            Navigator.pushNamed(context, AppRoutes.EDU_COURSE_DETAIL,
                arguments: {
                  "courseId": courses[index].courseId,
                  "title": courses[index].title,
                  "price": courses[index].price,
                  "desc": courses[index].description,
                  "thumbnailUrl": courses[index].thumbnailUrl,
                  "createdAt": courses[index].createdAt == null
                      ? "NA"
                      : courses[index]
                          .createdAt!
                          .toIso8601String()
                          .substring(0, 10)
                });
          },
          child: cstmGrid(
              course: courses[index]), // Replace with your custom widget
        );
      },
    );
  }
}
