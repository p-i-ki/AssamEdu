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
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(
                courses: courses,
              ),
            ),
            Container(
              color: Colors.red,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(courses: courses),
            ),
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(
                courses: courses,
              ),
            ),
            Container(
              color: Colors.blueGrey,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(courses: courses),
            ),
            Container(
              color: Colors.green,
              padding: const EdgeInsets.all(4),
              height: AppConstants.dHeight * 0.3,
              child: MyGridView(courses: courses),
            ),
          ],
        ),
      ),
    );
  }
}
