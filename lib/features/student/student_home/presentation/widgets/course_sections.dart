import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/entities/course.dart';
import 'package:assam_edu/features/student/student_home/presentation/widgets/my_grid_view.dart';
import 'package:flutter/material.dart';

class CourseSections extends StatelessWidget {
  const CourseSections({
    super.key,
    required this.tabController,
    required this.courses,
  });

  final TabController tabController;
  final List<CourseItem> courses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.dHeight * 0.5,
      width: AppConstants.dWidth,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppConstants.dRadius)),
        child: TabBarView(
          controller: tabController,
          children: [
            // All
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(
                courses: courses,
              ),
            ),
            // Popular
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(courses: courses),
            ),
            // New
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(
                courses: _newCourses(courses),
              ),
            ),
            // Categories
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(courses: courses),
            ),
            // BestSellers
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(courses: courses),
            ),
          ],
        ),
      ),
    );
  }

// New courses will be considerd if created within 1 week from now
  List<CourseItem> _newCourses(List<CourseItem> courses) {
    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    List<CourseItem> newCourses =
        courses.where((item) => item.createdAt!.isAfter(sevenDaysAgo)).toList();
    return newCourses;
  }
}
