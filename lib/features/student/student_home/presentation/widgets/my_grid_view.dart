import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/entities/course.dart';
import 'package:assam_edu/features/student/student_home/presentation/widgets/course_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyGridView extends StatelessWidget {
  final List<CourseItem> courses;
  const MyGridView({super.key, required this.courses});

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
            Navigator.pushNamed(context, AppRoutes.Course_Detail_Page,
                arguments: {
                  "courseId": courses[index].courseId,
                  "title": courses[index].title,
                  "price": courses[index].price,
                  "desc": courses[index].description,
                  "thumbnailUrl": courses[index].thumbnailUrl
                });
          },
          child: courseGrid(
              course: courses[index]), // Replace with your custom widget
        );
      },
    );
  }
}
